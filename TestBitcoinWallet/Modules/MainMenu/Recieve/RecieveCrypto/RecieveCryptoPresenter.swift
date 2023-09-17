//
//  RecieveCryptoPresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation

//MARK: - Presenter protocol
protocol RecieveCryptoPresenterProtocol: BasePresenter {
    func onCopyAddress(content: String?)
}


//MARK: - Main Presenter
final class RecieveCryptoPresenter: RecieveCryptoPresenterProtocol, BitcoinManagerJnector {
    
    //MARK: Private
    private weak var view: RecieveCryptoViewControllerProtocol?
    
    
    //MARK: Initialization
    init(view: RecieveCryptoViewControllerProtocol) {
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view?.setupMainUI()
        view?.setContentWalletAddressLabel(bitcoinManager?.getAddress())
    }
    
    func onCopyAddress(content: String?) {
        if let address = content?.trimmingCharacters(in: .whitespaces) {
            view?.copyAddressToPasteboard(address)
            view?.presentCopiedAlert()
        }
    }
}
