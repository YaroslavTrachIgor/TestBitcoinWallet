//
//  BalancePresenter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import Combine

//MARK: - Presenter protocol
protocol BalancePresenterProtocol: BasePresenter {
    func onRefreshBalance()
}


//MARK: - Main Presenter
final class BalancePresenter: BalancePresenterProtocol {
    
    //MARK: Private
    private var cancellables = Set<AnyCancellable>()
    private var adapterCancellables = Set<AnyCancellable>()
    private var adapter: BaseAdapter?
    private weak var view: BalanceViewControllerProtocol?
    
    
    //MARK: Initialization
    init(view: BalanceViewControllerProtocol) {
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        Manager.shared.adapterSubject
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.updateAdapters()
                }
                .store(in: &cancellables)

        view?.setupMainUI()
        updateAdapters()
    }
    
    func onRefreshBalance() {
        Manager.shared.refreshBalance()
    }
}


//MARK: - Main methods
extension BalancePresenter {
    
    //MARK: Private
    func updateAdapters() {
        adapter = Manager.shared.adapter
        Manager.shared.adapter?.start()
        
        adapterCancellables = Set()

        if let adapter = Manager.shared.adapter {
            Publishers.MergeMany(adapter.lastBlockPublisher, adapter.syncStatePublisher, adapter.balancePublisher)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.view?.updateLabelsContent(coinCode: adapter.coinCode,
                                                        balance: adapter.spendableBalance.formattedAmount)
                    }
                    .store(in: &adapterCancellables)
        }
    }
}
