//
//  SendCryptoViewController.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import UIKit

//MARK: - ViewController protocol
protocol SendCryptoViewControllerProtocol: BaseViewController {
    func presentSuccessAlert(hashString: String)
    func presentErrorAlert(message: String)
    func hideKeyboard()
}


//MARK: - Constants
private enum Constants {
    static let title = "Send"
    static let successTitle = "Success"
    static let errorTitle = "Error"
    static let okButtonTitle = "OK"
    static let cancelButtonTitle = "Cancel"
    static let continueButtonTitle = "Continue"
}


//MARK: - Main ViewController
final class SendCryptoViewController: UIViewController {

    var presenter: SendCryptoPresenterProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        presenter?.onTouchesEnded()
    }
    
    //MARK: @IBActions
    @IBAction func sendBTC(_ sender: Any) {
        presenter?.onSendCrypto(address: addressTextField.text,
                                stringAmount: amountTextField.text)
    }
}


//MARK: - ViewContoller protocol extension
extension SendCryptoViewController: SendCryptoViewControllerProtocol {
    
    //MARK: Internal
    func setupMainUI() {
        title = Constants.title
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func presentSuccessAlert(hashString: String) {
        let alert = UIAlertController(title: Constants.successTitle, message: "Transaction hash: \(hashString)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okButtonTitle, style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: Constants.errorTitle, message: "Error message: \(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okButtonTitle, style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
