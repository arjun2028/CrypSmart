//
//  HomeView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 19/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio:Bool=false
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack{
                homeHeader
                Spacer(minLength: 0)
            }
            
        }
    }
}

extension HomeView{
    private var homeHeader:some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
            Spacer()
            Text(showPortfolio ? "Portfolio" :"Live Prices").font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.ascent)
            Spacer()
            CircleButtonView(iconName: showPortfolio ? "chevron.left" : "chevron.right")
                .onTapGesture {
                    showPortfolio.toggle()
                }
            
        }.padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
