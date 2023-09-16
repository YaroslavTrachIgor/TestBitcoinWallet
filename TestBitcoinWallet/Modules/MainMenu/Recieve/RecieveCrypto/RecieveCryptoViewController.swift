//
//  RecieveCryptoViewController.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import UIKit
import Combine

//MARK: - ViewController protocol
protocol RecieveCryptoViewControllerProtocol: BaseViewController {
    func setContentWalletAddressLabel(_ content: String?)
    func copyAddressToPasteboard(_ content: String?)
    func presentCopiedAlert()
}

// Define Constants
private enum Constants {
    static let viewControllerTitle = "Receive"
    static let copiedAlertTitle = "Copied"
    static let pasteboardType = "public.plain-text"
    static let copiedAlertActionTitle = "OK"
    static let copyButtonImageName = "rectangle.portrait.on.rectangle.portrait"
}

//MARK: - Main ViewController
final class RecieveCryptoViewController: UIViewController {
    
    var presenter: RecieveCryptoPresenterProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet private weak var walletAddressLabel: UILabel!
    @IBOutlet private weak var copyWalletAddressButton: UIButton!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    //MARK: @IBActions
    @IBAction func copyAddress(_ sender: Any) {
        presenter?.onCopyAddress(content: walletAddressLabel.text!)
    }
}

//MARK: - ViewController protocol extension
extension RecieveCryptoViewController: RecieveCryptoViewControllerProtocol {
    
    //MARK: Internal
    func setContentWalletAddressLabel(_ content: String?) {
        walletAddressLabel.text = content
    }
    
    func copyAddressToPasteboard(_ content: String?) {
        guard let content = content else { return }
        UIPasteboard.general.setValue(content, forPasteboardType: Constants.pasteboardType)
    }
    
    func presentCopiedAlert() {
        let alert = UIAlertController(title: Constants.copiedAlertTitle, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.copiedAlertActionTitle, style: .cancel))
        present(alert, animated: true)
    }
    
    func setupMainUI() {
        title = Constants.viewControllerTitle
        setupCopyWalletAddressButton()
    }
}

//MARK: - Main methods
private extension RecieveCryptoViewController {
    
    //MARK: Private
    func setupCopyWalletAddressButton() {
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .label
        buttonConfig.image = UIImage(systemName: Constants.copyButtonImageName)
        buttonConfig.title = nil
        copyWalletAddressButton.configuration = buttonConfig
    }
}
