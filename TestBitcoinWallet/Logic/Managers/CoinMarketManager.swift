//
//  CoinMarketManager.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-30.
//

import Foundation
import Alamofire
import UIKit

private enum Constants {
    static let API_KEY = "736c22c6-1b5d-4f50-9db9-0d67014f238a"
    static let baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    static let startParam = "1"
    static let limitParam = "5000"
    static let convertParam = "USD"
    static let acceptHeaderValue = "application/json"
}


protocol CoinMarketManagerProtocol {
    func getCryptoCoins(completion: @escaping ((Result<[Crypto], TBWError>) -> Void))
}


final class CoinMarketManager {

    //MARK: Internal
    func getCryptoCoins(completion: @escaping ((Result<[Crypto], TBWError>) -> Void)) {
        let apiUrl = URL(string: Constants.baseURL)!

        var components = URLComponents(url: apiUrl, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "start", value: Constants.startParam),
            URLQueryItem(name: "limit", value: Constants.limitParam),
            URLQueryItem(name: "convert", value: Constants.convertParam)
        ]

        let headers: HTTPHeaders = [
            HTTPHeader(name: "Accept", value: Constants.acceptHeaderValue),
            HTTPHeader(name: "X-CMC_PRO_API_KEY", value: Constants.API_KEY)
        ]

        AF.request(components.url!, headers: headers).responseDecodable(of: CryptoCoinsResponse.self) { (response: DataResponse<CryptoCoinsResponse, AFError>) in
            if let result = response.value {
                completion(.success(result.data))
            } else {
                completion(.failure(.custom(description: "Alamofire Error")))
            }
        }
    }
}





enum TBWError: Error {
    case custom(description: String)

    var errorDescription: String? {
        switch self {
        case .custom(let description):
            return description
        }
    }
}
