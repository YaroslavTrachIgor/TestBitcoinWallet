//
//  SetupWalletViewController.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-14.
//

import UIKit

//MARK: - ViewController protocol
protocol SetupWalletViewControllerProtocol: BaseViewController {
    func presentValidationErrorViewController(with error: Error)
    func presentMenuTabBarController()
    func changeContentSeedPhraseTextView(text: String)
}


//MARK: - Main ViewController
final class SetupWalletViewController: UIViewController {

    var presenter: SetupWalletPresenterProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet private weak var seedPhraseTextView: UITextView!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    //MARK: @IBActions
    @IBAction func createWallet(_ sender: Any) {
        presenter?.onCreateWallet(words: seedPhraseTextView.text)
    }
    
    @IBAction func updatePhrase(_ sender: Any) {
        presenter?.onUpdatePhrase()
    }
}


//MARK: - ViewController protocol extension
extension SetupWalletViewController: SetupWalletViewControllerProtocol {
    
    //MARK: Internal
    func setupMainUI() {
        setupSeedPhraseTextView()
        view.backgroundColor = .secondarySystemGroupedBackground
    }
    
    func presentValidationErrorViewController(with error: Error) {
        let alert = UIAlertController(title: "Validation Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func presentMenuTabBarController() {
        let tabBarController = UITabBarController()
        let mainRouter = MainRouter(tabBarController: tabBarController)
        tabBarController.modalPresentationStyle = .fullScreen
        mainRouter.start()
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    func changeContentSeedPhraseTextView(text: String) {
        seedPhraseTextView.text = text
    }
}


//MARK: - Main methods
private extension SetupWalletViewController {
    
    //MARK: Private
    func setupSeedPhraseTextView() {
        seedPhraseTextView.backgroundColor = .black
        seedPhraseTextView.textColor = .white
        seedPhraseTextView.layer.cornerRadius = 4
    }
}
