//
//  CoinLogoView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 28/06/25.
//

import SwiftUI

struct CoinLogoView: View {
    let coin:CoinModel
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50,height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.ascent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name.uppercased())
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                
            
        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin).previewLayout(.sizeThatFits)
}
