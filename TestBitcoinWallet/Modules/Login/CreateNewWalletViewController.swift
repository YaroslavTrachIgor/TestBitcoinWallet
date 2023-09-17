//
//  CreateNewWalletViewController.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-14.
//

import UIKit
import HdWalletKit

class CreateNewWalletViewController: UIViewController {

    @IBOutlet private weak var walletAddressLabel: UILabel!
    @IBOutlet private weak var seedPhraseTextView: UITextView!
    
    private var adapter: BaseAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    //MARK: @IBActions
    @IBAction func createWallet(_ sender: Any) {
        
    }
    
    @IBAction func copyWalletAddress(_ sender: Any) {
        
    }
    
    @IBAction func updatePhrase(_ sender: Any) {
        if let generatedWords = try? Mnemonic.generate() {
            seedPhraseTextView.text = generatedWords.joined(separator: " ")
            walletAddressLabel.text = adapter?.receiveAddress()
        }
    }
}


private extension CreateNewWalletViewController {
    func prepareUI() {
        seedPhraseTextView.backgroundColor = .secondarySystemGroupedBackground
        seedPhraseTextView.textColor = .label
        seedPhraseTextView.text = Configuration.shared.defaultWords[0]
        
        view.backgroundColor = .secondarySystemGroupedBackground
        
        Manager.shared.save(restoreData: walletAddressLabel.text!)
        Manager.shared.save(syncModeIndex: 1)
        
        adapter = Manager.shared.adapter
        
        walletAddressLabel.text = adapter?.receiveAddress()
    }
}
