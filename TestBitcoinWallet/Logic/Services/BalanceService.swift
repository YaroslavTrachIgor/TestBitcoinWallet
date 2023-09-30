//
//  BalanceService.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-29.
//

import Foundation

//MARK: - Client protocol
protocol BalanceClientProtocol: BitcoinManagerJnector {
    func getSpendableBalance() -> String!
    func initializeBitcoinWallet()
}


//MARK: - Main Client
final class BalanceClient: BalanceClientProtocol {
    
    //MARK: Internal
    func getSpendableBalance() -> String! {
        bitcoinManager?.getSpendableBalance()
    }
    
    func initializeBitcoinWallet() {
        bitcoinManager?.initializeBitcoinWallet()
    }
}
