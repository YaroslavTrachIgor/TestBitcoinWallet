//
//  CryptoCoinsResponse.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-10-02.
//

import Foundation

struct CryptoCoinsResponse: Codable {
    let data: [Crypto]
}

struct Crypto: Codable {
    let id: Int
    let name: String
    let symbol: String
    let slug: String
    let quote: Quote
}

struct Quote: Codable {
    let USD: QuoteDetail
}

struct QuoteDetail: Codable {
    let price: Double
    let volume_24h: Double
    let volume_change_24h: Double
    let percent_change_1h: Double
    let percent_change_24h: Double
    let percent_change_7d: Double
    let percent_change_30d: Double
    let percent_change_60d: Double
    let percent_change_90d: Double
    let market_cap: Double
    let market_cap_dominance: Double
    let fully_diluted_market_cap: Double
    let tvl: Double?
    let last_updated: String
}
