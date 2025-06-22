//
//  CoinImageService.swift
//  CrypSmart
//
//  Created by Arjun Singh on 11/06/25.
//

import Foundation
import SwiftUI
import Combine
class CoinImageService{
    @Published var image:UIImage?=nil
    
    var imageSubscription:AnyCancellable?
    var FileManager=LocalFileManager.instance
    var urlString:String
    var folderName="Images_folder"
    init(urlString:String){
        self.urlString=urlString
        getCoinImage()
    }
    
    private func accessCoinImage(){
        if let savedImage=FileManager.getImage(imageName: urlString, folderName: folderName){
            image=savedImage
            print("Retrieved image from file manager")
        }
        else{
            getCoinImage()
            print("Downloading image")
        }
    }
    
    private func getCoinImage() {
        guard let url = URL(string: self.urlString) else {
            return
        }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { imageData -> UIImage? in
                return UIImage(data: imageData)
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnImage in
                guard let self = self, let image=returnImage else {
                    return
                }
                self.image = image
                self.imageSubscription?.cancel()
                self.FileManager.saveImage(image: image, imageName: self.urlString, folderName: self.folderName)
            }
    }

}
