//
//  LoginServise.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-29.
//

import Foundation
import HdWalletKit

//MARK: - Client protocol
protocol LoginServiceProtocol: BitcoinManagerJnector {
    func generateNewSeedPhrase(completion: @escaping ((String?) -> ()))
    func login(words: String?)
}


//MARK: - Main Client
final class LoginService: LoginServiceProtocol {
    
    //MARK: Internal
    func generateNewSeedPhrase(completion: @escaping ((String?) -> ())) {
        do {
            let generatedWords = try Mnemonic.generate()
            let singleWordsString = generatedWords.joined(separator: " ")
            completion(singleWordsString)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func login(words: String?) {
        guard let restoreData = words else { return }
        bitcoinManager?.login(restoreData: restoreData)
    }
}
