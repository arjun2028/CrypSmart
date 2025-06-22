//
//  HomeViewModel.swift
//  CrypSmart
//
//  Created by Arjun Singh on 22/05/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject,Observable {
    @Published var allcoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText:String=""
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Subscription 1: Update allCoins from coinDataService
        coinDataService.$allCoins
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedCoins in
                self?.allcoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Subscription 2: Filtered coins based on searchText and allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text, startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowercasedText = text.lowercased()
                return startingCoins.filter { coin in
                    return coin.name.lowercased().contains(lowercasedText) ||
                           coin.id.lowercased().contains(lowercasedText) ||
                           coin.symbol.lowercased().contains(lowercasedText)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] filteredCoins in
                self?.allcoins = filteredCoins
            }
            .store(in: &cancellables)
    }

}

