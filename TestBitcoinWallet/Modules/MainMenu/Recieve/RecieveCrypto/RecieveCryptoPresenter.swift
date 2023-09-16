//
//  RecieveCryptoPresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import Combine

//MARK: - Presenter protocol
protocol RecieveCryptoPresenterProtocol: BasePresenter {
    func onCopyAddress(content: String?)
}


//MARK: - Main Presenter
final class RecieveCryptoPresenter: RecieveCryptoPresenterProtocol {
    
    //MARK: Private
    private weak var view: RecieveCryptoViewControllerProtocol?
    private var adapter: BaseAdapter?
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: Initialization
    init(view: RecieveCryptoViewControllerProtocol) {
        self.view = view
        
        Manager.shared.adapterSubject
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.adapter = Manager.shared.adapter
                }
                .store(in: &cancellables)
        
        adapter = Manager.shared.adapter
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view?.setupMainUI()
        view?.setContentWalletAddressLabel(adapter?.receiveAddress())
    }
    
    func onCopyAddress(content: String?) {
        if let address = content?.trimmingCharacters(in: .whitespaces) {
            view?.copyAddressToPasteboard(address)
            view?.presentCopiedAlert()
        }
    }
}
