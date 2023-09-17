//
//  BitcoinManager.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-16.
//

import Foundation
import Combine
import BitcoinCore
import HsToolKit
import HdWalletKit
import BitcoinKit

//MARK: - Manager Injector protocol
protocol BitcoinManagerJnector {
    var bitcoinManager: BitcoinManager? { get }
}


//MARK: - Manager Injector protocol extension
extension BitcoinManagerJnector {
    var bitcoinManager: BitcoinManager? {
        return BitcoinManager.shared
    }
}


//MARK: - Sending Crypto Errors enum
enum SendError: Error {
    case insufficientAmount
}


//MARK: - Constants
private enum Constants {
    static let walletId = "walletId"
    static let loggerScope = "BitcoinKit"
    static let restoreDataKey = "restore_data"
    static let defaultAddress = ""
    static let minLogLevel: Logger.Level = .verbose
    static let testNet = true
    static let purpose = Purpose.bip86
    static let confirmationsThreshold = 3
    static let coinRate: Decimal = pow(10, 8)
    static let feeRate = 1000
}


typealias BitcoinManagerBaseErrorCompletionHandler = ((Error) -> ())


//MARK: - Main Manager
final class BitcoinManager {
    
    //MARK: Static
    static let shared = BitcoinManager()
    
    //MARK: Private
    @UserDefault(Constants.restoreDataKey, defaultValue: nil)
    private var restoreData: String?
    private var bitcoinKit: Kit?
    
    private init() {}
    
    
    //MARK: Public functions
    func isWalletCreated() -> Bool {
        !(savedRestoreData == nil)
    }
    
    func login(restoreData: String) {
        save(restoreData: restoreData)
    }
    
    func initializeBitcoinWallet() {
        let minLogLevel = Constants.minLogLevel
        let loggerScope = Constants.loggerScope
        let logger = Logger(minLogLevel: minLogLevel)
        let words = (savedRestoreData?.components(separatedBy: .whitespacesAndNewlines))!
        let networkType: Kit.NetworkType = Constants.testNet ? .testNet : .mainNet
        let purpose = Constants.purpose
        let walletId = Constants.walletId
        let confirmationsThreshold = Constants.confirmationsThreshold
        guard let seed = Mnemonic.seed(mnemonic: words) else { return }
        bitcoinKit = try! Kit(seed: seed,
                              purpose: purpose,
                              walletId: walletId,
                              syncMode: .api,
                              networkType: networkType,
                              confirmationsThreshold: confirmationsThreshold,
                              logger: logger.scoped(with: loggerScope))
        bitcoinKit?.start()
    }
    
    func getSpendableBalance() -> String {
        let coinRate = Constants.coinRate
        let spendableBalance = bitcoinKit?.balance.spendable
        let decimalSpendableBalance = (Decimal(spendableBalance ?? 0))
        let spendableBalanceBTC = (decimalSpendableBalance / coinRate)
        return spendableBalanceBTC.formattedAmount
    }
    
    func getUnspendableBalance() -> String {
        let coinRate = Constants.coinRate
        let unspendableBalance = bitcoinKit?.balance.unspendable
        let decimalUnspendableBalance = (Decimal(unspendableBalance ?? 0))
        let unspendableBalanceBTC = (decimalUnspendableBalance / coinRate)
        return unspendableBalanceBTC.formattedAmount
    }
    
    func getAddress() -> String {
        let bitcoinAddress = bitcoinKit?.receiveAddress()
        let defaultAddress = Constants.defaultAddress
        return bitcoinAddress ?? defaultAddress
    }
    
    @discardableResult
    func send(to address: String,
              amount: Decimal,
              completion: @escaping BitcoinManagerBaseErrorCompletionHandler) -> Data? {
        do {
            let feeRate = Constants.feeRate
            let satoshiAmount = convertToSatoshi(value: amount)
            let transaction = try bitcoinKit?.send(to: address,
                                                   value: satoshiAmount,
                                                   feeRate: feeRate,
                                                   sortType: .shuffle)
            return transaction?.header.dataHash ?? nil
        } catch {
            DispatchQueue.main.async {
                completion(error)
            }
            return nil
        }
    }
    
    func availableBalance(for address: String?,
                          pluginData: [UInt8: IPluginData] = [:]) -> Decimal {
        let coinRate = Constants.coinRate
        let feeRate = Constants.feeRate
        let amount = (try? bitcoinKit?.maxSpendableValue(toAddress: address,
                                                         feeRate: feeRate,
                                                         pluginData: pluginData)) ?? 0
        return Decimal(amount) / coinRate
    }
    
    func validate(address: String,
                  completion: @escaping BitcoinManagerBaseErrorCompletionHandler) {
        do {
            try bitcoinKit?.validate(address: address)
        } catch {
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    func validate(amount: Decimal, address: String?) throws {
        let availableBalance = availableBalance(for: address)
        guard amount <= availableBalance else {
            throw SendError.insufficientAmount
        }
    }
}


//MARK: - Main methods
private extension BitcoinManager {
    
    //MARK: Private
    var savedRestoreData: String? {
        return restoreData
    }
    
    func save(restoreData: String) {
        self.restoreData = restoreData
    }
    
    func convertToSatoshi(value: Decimal) -> Int {
        let coinRate = Constants.coinRate
        let coinValue: Decimal = value * coinRate
        let handler = NSDecimalNumberHandler(roundingMode: .plain,
                                             scale: 0,
                                             raiseOnExactness: false,
                                             raiseOnOverflow: false,
                                             raiseOnUnderflow: false,
                                             raiseOnDivideByZero: false)
        let decimalNum = NSDecimalNumber(decimal: coinValue)
        let roundedNum = decimalNum.rounding(accordingToBehavior: handler).intValue
        return roundedNum
    }
}
