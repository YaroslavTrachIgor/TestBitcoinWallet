//
//  BalanceViewController.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import UIKit
import Combine

//MARK: - Constants
private enum Constants {
    static let title = "Balance"
    static let coinCode = "BTC"
    static let refreshButtonTitle = "Refresh"
    static let refreshButtonImageName = "arrow.clockwise"
}


//MARK: - ViewController protocol
protocol BalanceViewControllerProtocol: BaseViewController {
    func updateLabelsContent(balance: String?)
}


//MARK: - Main ViewController
final class BalanceViewController: UIViewController {
    
    var presenter: BalancePresenterProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet weak var coinCodeLabel: UILabel!
    @IBOutlet weak var coinBalanceLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    @IBAction func refreshBalance(_ sender: Any) {
        presenter?.onRefreshBalance()
    }
}


//MARK: - ViewController protocol extension
extension BalanceViewController: BalanceViewControllerProtocol {
    
    //MARK: Internal
    func setupMainUI() {
        title = Constants.title
        coinCodeLabel.text = Constants.coinCode
        setupRefreshButton()
    }
    
    func updateLabelsContent(balance: String?) {
        coinBalanceLabel.text = balance
    }
}


//MARK: - Main methods
private extension BalanceViewController {
    
    //MARK: Private
    func setupRefreshButton() {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = .link
        buttonConfig.baseForegroundColor = .white
        buttonConfig.image = UIImage(systemName: Constants.refreshButtonImageName)
        buttonConfig.imagePadding = 6
        buttonConfig.title = Constants.refreshButtonTitle
        refreshButton.configuration = buttonConfig
    }
}
