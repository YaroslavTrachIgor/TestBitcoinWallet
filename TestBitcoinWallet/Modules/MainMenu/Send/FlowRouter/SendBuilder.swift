//
//  SendBuilder.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-17.
//

import Foundation
import UIKit

//MARK: - Bulder protocol
protocol SendBuilderProtocol {
    func showSendCryptoVC() -> UIViewController
}


//MARK: - Main Bulder
final class SendBuilder {
    
    //MARK: Weak
    weak var coordinator: Coordinator!
    
    
    //MARK: Initialization
    init(coordinator: Coordinator!) {
        self.coordinator = coordinator
    }
}


//MARK: - Builder protocol extension
extension SendBuilder: SendBuilderProtocol {
    
    //MARK: Internal
    internal func showSendCryptoVC() -> UIViewController {
        let viewController = SendCryptoViewController()
        let presenter = SendCryptoPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
