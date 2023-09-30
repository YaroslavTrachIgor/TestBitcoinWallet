//
//  RecieveCryptoClientProtocol.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-29.
//

import Foundation

//MARK: - Client protocol
protocol RecieveCryptoClientProtocol: BitcoinManagerJnector {
    func getWalletAddress() -> String!
}


//MARK: - Main Client
final class RecieveCryptoClient: RecieveCryptoClientProtocol {
    
    //MARK: Internal
    func getWalletAddress() -> String! {
        bitcoinManager?.getAddress()
    }
}
