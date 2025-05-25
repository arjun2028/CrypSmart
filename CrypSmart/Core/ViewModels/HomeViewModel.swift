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
    
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        coinDataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allcoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}

