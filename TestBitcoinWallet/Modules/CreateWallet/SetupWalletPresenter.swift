//
//  SetupWalletPresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import HdWalletKit

//MARK: - Presenter protocol
protocol SetupWalletPresenterProtocol: BasePresenter {
    func onUpdatePhrase()
    func onCreateWallet(words: String?)
}


//MARK: - Main Presenter
final class SetupWalletPresenter: SetupWalletPresenterProtocol {
    
    //MARK: Private
    private weak var view: SetupWalletViewControllerProtocol?
    private var adapter: BaseAdapter?
    
    
    //MARK: Initialization
    init(view: SetupWalletViewControllerProtocol) {
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onCreateWallet(words: String?) {
        guard let text = words else {
            return
        }
        let successBlock = {
            Manager.shared.login(restoreData: text, syncModeIndex: 0)
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.presentMenuTabBarController()
            }
        }

        let errorBlock: (Error) -> Void = { [weak self] error in
            self?.view?.presentValidationErrorViewController(with: error)
        }

        let mnemonicWords = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        if mnemonicWords.count > 1 {
            do {
                try Mnemonic.validate(words: mnemonicWords)
                successBlock()
            } catch {
                errorBlock(error)
            }
        } else {
            do {
                _ = try HDExtendedKey(extendedKey: text)
                successBlock()
            } catch {
                errorBlock(error)
            }
        }
    }
    
    func onUpdatePhrase() {
        updateSeed()
    }
    
    func onViewDidLoad() {
        updateSeed()
        view?.setupMainUI()
    }
}


//MARK: - Main methods
private extension SetupWalletPresenter {
    
    //MARK: Private
    func updateSeed() {
        if let generatedWords = try? Mnemonic.generate() {
            let singleWordsString = generatedWords.joined(separator: " ")
            view?.changeContentSeedPhraseTextView(text: singleWordsString)
        }
    }
}
