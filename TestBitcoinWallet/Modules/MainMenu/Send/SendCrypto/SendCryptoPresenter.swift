//
//  SendCryptoPresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-16.
//

import Foundation
import HdWalletKit

//MARK: - Constants
private enum Constants {
    static let emptyAddressMessage = "Address is Empty."
    static let emptyAmountMessage = "Amount is Empty."
    static let invalidAddressMessage = "Invalid Address."
    static let invalidAmountMessage = "Invalid Amount."
    static let emptyTransactionHashMessage = "Empty Transaction Hash."
}


//MARK: - Presenter protocol
protocol SendCryptoPresenterProtocol: BasePresenter {
    func onSendCrypto(address: String?, stringAmount: String?)
    func onTouchesEnded()
}


//MARK: - Main Presenter
final class SendCryptoPresenter: SendCryptoPresenterProtocol, BitcoinManagerJnector {
    
    //MARK: Private
    private var sendCryptoService: SendCryptoClientProtocol?
    private weak var view: SendCryptoViewControllerProtocol?
    
    
    //MARK: Initialization
    init(view: SendCryptoViewControllerProtocol,
         sendCryptoService: SendCryptoClientProtocol) {
        self.sendCryptoService = sendCryptoService
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view?.setupMainUI()
    }
    
    func onSendCrypto(address: String?, stringAmount: String?) {
        guard let address = address, !address.isEmpty else {
            self.view?.presentErrorAlert(message: Constants.emptyAddressMessage)
            return
        }
        
        guard let stringAmount = stringAmount, !stringAmount.isEmpty else {
            self.view?.presentErrorAlert(message: Constants.emptyAmountMessage)
            return
        }
        
        sendCryptoService?.validate(address: address) { error in
            self.view?.presentErrorAlert(message: Constants.invalidAddressMessage)
            return
        }
        
        guard let amount = Decimal(string: stringAmount) else {
            self.view?.presentErrorAlert(message: Constants.invalidAmountMessage)
            return
        }
        
        let transactionHash = sendCryptoService?.send(address: address, amount: amount) { error in
            self.view?.presentErrorAlert(message: error.localizedDescription)
            return
        }
        
        guard let transactionHash = transactionHash else {
            self.view?.presentErrorAlert(message: Constants.emptyTransactionHashMessage)
            return
        }
        
        let hashString = String(decoding: transactionHash, as: UTF8.self)
        view?.presentSuccessAlert(hashString: hashString)
    }
    
    func onTouchesEnded() {
        view?.hideKeyboard()
    }
}
