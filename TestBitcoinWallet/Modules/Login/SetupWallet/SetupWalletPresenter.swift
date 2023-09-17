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


//MARK: - Presenter Coordinator delegate protocol
protocol SetupWalletPresenterCoordinatorDelegate {
    func presenter(_ presenter: SetupWalletPresenterProtocol)
}


//MARK: - Main Presenter
final class SetupWalletPresenter: SetupWalletPresenterProtocol, BitcoinManagerJnector {
    
    //MARK: Private
    private weak var view: SetupWalletViewControllerProtocol?
    private var delegate: SetupWalletPresenterCoordinatorDelegate?
    
    
    //MARK: Initialization
    init(view: SetupWalletViewControllerProtocol,
         delegate: SetupWalletPresenterCoordinatorDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onCreateWallet(words: String?) {
        guard let restoreData = words else { return }
        bitcoinManager?.login(restoreData: restoreData)
        delegate?.presenter(self)
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
