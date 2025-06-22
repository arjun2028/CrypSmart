//
//  CoinImageViewModel.swift
//  CrypSmart
//
//  Created by Arjun Singh on 11/06/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel:ObservableObject{
    @Published var image:UIImage?=nil
    @Published var isLoading:Bool=false
    
    private let coin:CoinModel
    private let dataService:CoinImageService
    
    var cancellable=Set<AnyCancellable>()
    init(coin:CoinModel){
        self.coin=coin
        self.dataService=CoinImageService(urlString: coin.image )
        addSubscribers()
        self.isLoading=true
    }
    
    func addSubscribers() {
        dataService.$image
            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
            .sink { [weak self] returnedImage in
                self?.isLoading = false
                self?.image = returnedImage
            }
            .store(in: &cancellable)
    }
    
}
