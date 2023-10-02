//
//  CryptoCoinsListView.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-10-02.
//

import SwiftUI
import Combine

struct CoinsListView: View {
    @StateObject var viewModel = CoinsListViewModel()
    @State private var searchText = ""

    var filteredCoins: [CryptoUIModel] {
        if searchText.isEmpty {
            return viewModel.coins
        } else {
            return viewModel.coins.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section(header:
                            Text("Top Rated".uppercased())
                    .font(.system(size: 14, weight: .regular))
                ) {
                    ForEach(filteredCoins.indices, id: \.self) { index in
                        let coin = filteredCoins[index]
                        HStack {
                            RemoteImage(coin.iconURL, cornerRadius: 8)
                                .frame(width: 45, height: 45)
                                .padding(.trailing, 6)
                            VStack(alignment: .leading, content: {
                                HStack {
                                    Text("\(coin.name)")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(.label))
                                        .padding([.bottom], 0.6)
                                    Text("\(coin.symbol)")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color(.systemGray4))
                                }
                                VStack {
                                    Text("  \(index + 1)  ")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color(.systemGray2))
                                }
                                .background(Color(.systemGray6))
                                .frame(height: 18)
                                .cornerRadius(5)
                            })
                            Spacer()
                            VStack(alignment: .trailing, content: {
                                Text("$\(String(format: "%.3f", coin.price))")
                                    .font(.system(size: 14, weight: .regular))
                                    .padding([.bottom], 1)
                                    .foregroundColor(Color(.systemGray3))
                                Text("\(String(format: "%.3f", coin.pricePercentChange))%")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(viewModel.getPriceChangeForegroundColor(for: index)))
                            })
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Crypto Coins")
            .searchable(text: $searchText)
        }
        .onAppear {
            viewModel.getCoins()
        }
    }
}
                            
                            
                            
                            
class RemoteImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellables = Set<AnyCancellable>()

    func load(from url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.image = image
            }
            .store(in: &cancellables)
    }
}

struct RemoteImage: View {
    
    @ObservedObject private var imageLoader = RemoteImageLoader()
    private var cornerRadius: CGFloat = 0
    private var imageURL: URL

    init(_ url: URL, cornerRadius: CGFloat = 0) {
        imageURL = url
        imageLoader.load(from: url)
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            Image(systemName: "circle")
        }
    }
}
