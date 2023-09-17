//
//  RecieveBuilder.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-17.
//

import Foundation
import UIKit

//MARK: - Bulder protocol
protocol RecieveBuilderProtocol {
    func showRecieveCryptoVC() -> UIViewController
}


//MARK: - Main Bulder
final class RecieveBuilder {
    
    //MARK: Weak
    weak var coordinator: Coordinator!
    
    
    //MARK: Initialization
    init(coordinator: Coordinator!) {
        self.coordinator = coordinator
    }
}


//MARK: - Builder protocol extension
extension RecieveBuilder: RecieveBuilderProtocol {
    
    //MARK: Internal
    internal func showRecieveCryptoVC() -> UIViewController {
        let viewController = RecieveCryptoViewController()
        let presenter = RecieveCryptoPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
