//
//  BalancePresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation

//MARK: - Presenter protocol
protocol BalancePresenterProtocol: BasePresenter {
    func onRefreshBalance()
}


//MARK: - Main Presenter
final class BalancePresenter: BalancePresenterProtocol, BitcoinManagerJnector {
    
    //MARK: Private
    private weak var view: BalanceViewControllerProtocol?
    
    
    //MARK: Initialization
    init(view: BalanceViewControllerProtocol) {
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view?.setupMainUI()
        bitcoinManager?.initializeBitcoinWallet()
        view?.updateLabelsContent(balance: bitcoinManager?.getSpendableBalance())
        
    }
    
    func onRefreshBalance() {
        view?.updateLabelsContent(balance: bitcoinManager?.getSpendableBalance())
    }
}
