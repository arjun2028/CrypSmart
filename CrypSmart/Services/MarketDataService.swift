//
//  MarketDataService.swift
//  CrypSmart
//
//  Created by Arjun Singh on 26/06/25.
//
 

import Foundation
import Combine

class MarketDataService{
    @Published var marketData:MarketData?=nil
    var marketDataSubscription: AnyCancellable?

    init(){
        getData()
    }
    
    private func getData(){
        guard let url=URL(string: "https://api.coingecko.com/api/v3/global")
        else{
            return
        }
        
        marketDataSubscription=NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink{(completion) in
                switch completion{
                case .finished:
                        break
                case .failure(let error):
                    print(error.localizedDescription)
                }}receiveValue: { [weak self](returnedMarketData) in
                    self?.marketData=returnedMarketData.data
                    self?.marketDataSubscription?.cancel()
                }
     
    }
}
