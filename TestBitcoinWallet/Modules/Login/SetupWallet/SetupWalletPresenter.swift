//
//  SetupWalletPresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation

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
    private var loginService: LoginServiceProtocol?
    private weak var view: SetupWalletViewControllerProtocol?
    private var delegate: SetupWalletPresenterCoordinatorDelegate?
    
    
    //MARK: Initialization
    init(view: SetupWalletViewControllerProtocol,
         delegate: SetupWalletPresenterCoordinatorDelegate,
         loginService: LoginServiceProtocol) {
        self.loginService = loginService
        self.delegate = delegate
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onCreateWallet(words: String?) {
        loginService?.login(words: words)
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
        loginService?.generateNewSeedPhrase(completion: { [weak self] words in
            if let text = words {
                self?.view?.changeContentSeedPhraseTextView(text: text)
            }
        })
    }
}
