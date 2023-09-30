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
    private var recieveService: RecieveCryptoClientProtocol?
    private weak var view: RecieveCryptoViewControllerProtocol?
    
    
    //MARK: Initialization
    init(view: RecieveCryptoViewControllerProtocol,
         recieveService: RecieveCryptoClientProtocol) {
        self.recieveService = recieveService
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view?.setupMainUI()
        view?.setContentWalletAddressLabel(recieveService?.getWalletAddress())
    }
    
    func onCopyAddress(content: String?) {
        if let address = content?.trimmingCharacters(in: .whitespaces) {
            view?.copyAddressToPasteboard(address)
            view?.presentCopiedAlert()
        }
    }
}
