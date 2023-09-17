//
//  BalanceBuilder.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-17.
//

import Foundation
import UIKit

//MARK: - Bulder protocol
protocol BalanceBuilderProtocol {
    func showWalletBalanceVC() -> UIViewController
}


//MARK: - Main Bulder
final class BalanceBuilder {
    
    //MARK: Weak
    weak var coordinator: Coordinator!
    
    
    //MARK: Initialization
    init(coordinator: Coordinator!) {
        self.coordinator = coordinator
    }
}


//MARK: - Builder protocol extension
extension BalanceBuilder: BalanceBuilderProtocol {
    
    //MARK: Internal
    internal func showWalletBalanceVC() -> UIViewController {
        let viewController = BalanceViewController()
        let presenter = BalancePresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
