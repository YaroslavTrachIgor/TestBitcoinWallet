//
//  CryptoCoinsMenuBuilder.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-10-02.
//

import Foundation
import UIKit
import SwiftUI

//MARK: - Bulder protocol
protocol CryptoCoinsMenuBuilderProtocol {
    func showCryptoCoinsMenuVC() -> UIViewController
}


//MARK: - Main Bulder
final class CryptoCoinsMenuBuilder {
    
    //MARK: Weak
    weak var coordinator: Coordinator!
    
    
    //MARK: Initialization
    init(coordinator: Coordinator!) {
        self.coordinator = coordinator
    }
}


//MARK: - Builder protocol extension
extension CryptoCoinsMenuBuilder: CryptoCoinsMenuBuilderProtocol {
    
    //MARK: Internal
    internal func showCryptoCoinsMenuVC() -> UIViewController {
        let view = CoinsListView()
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
}

