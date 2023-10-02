//
//  CoinsListViewModel.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-10-02.
//

import Foundation
import Combine
import SwiftUI

final class CoinsListViewModel: ObservableObject {
    
    private let coinMarketManager = CoinMarketManager()
    
    @Published var coins: [CryptoUIModel] = []
    @Published var coinsIcons: [UIImage] = []
    
    func getCoins() {
        coinMarketManager.getCryptoCoins { result in
            switch result {
            case .success(let coins):
                DispatchQueue.main.async { [weak self] in
                    for coin in coins {
                        self?.coins.append(CryptoUIModel(pricePercentChange: coin.quote.USD.percent_change_24h,
                                                        name: coin.name,
                                                         iconURL: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(coin.id).png")!,
                                                        price: coin.quote.USD.price,
                                                        symbol: coin.symbol,
                                                        id: coin.id))
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPriceChangeForegroundColor(for index: Int) -> UIColor {
        if coins[index].pricePercentChange > 0 {
            return .init(hexString: "#06d664", alpha: 1)
        } else {
            return .red
        }
    }
}



struct CryptoUIModel {
    let pricePercentChange: Double!
    let name: String!
    let iconURL: URL!
    let price: Double!
    let symbol: String!
    let id: Int!
}
