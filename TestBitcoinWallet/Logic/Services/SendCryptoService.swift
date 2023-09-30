//
//  SendService.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-29.
//

import Foundation

//MARK: - Client protocol
protocol SendCryptoClientProtocol: BitcoinManagerJnector {
    func validate(address: String!, completion: @escaping ((Error) -> ()))
    func send(address: String!, amount: Decimal!, completion: @escaping ((Error) -> ())) -> Data?
}


//MARK: - Main Client
final class SendCryptoClient: SendCryptoClientProtocol {
    
    //MARK: Internal
    func validate(address: String!, completion: @escaping ((Error) -> ())) {
        bitcoinManager?.validate(address: address, completion: { error in
            completion(error)
        })
    }
    
    func send(address: String!, amount: Decimal!, completion: @escaping ((Error) -> ())) -> Data? {
        let transactionHash = bitcoinManager?.send(to: address, amount: amount) { error in
            completion(error)
            return
        }
        return transactionHash
    }
}
