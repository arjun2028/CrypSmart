//
//  HomeView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 19/05/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm:HomeViewModel
    @State private var showPortfolio:Bool=false
    @State private var showPortfolioView:Bool=false
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            VStack{
                
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBar(searchText: $vm.searchText).padding()
                HStack{
                    Text("Coin")
                    Spacer()
                    if showPortfolio{
                        Text("Holdings")
                    }
                    Text("Price").frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
                }.padding(.horizontal)
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
                
                if !showPortfolio{
                    List{
                        
                        ForEach(vm.allcoins){
                            coin in
                            CoinRowView(coin: coin, showHolding: false)
                        }
                    }.listStyle(.plain).transition(.move(edge: .leading))
                    
                }
                if showPortfolio{
                    List{
                        
                        ForEach(vm.portfolioCoins){
                            coin in
                            CoinRowView(coin: coin, showHolding: false)
                        }
                    }.listStyle(.plain).transition(.move(edge: .leading))
                    
                }
                Spacer(minLength: 0)
            }
            
        }
    }
}

extension HomeView{
    private var homeHeader:some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    if showPortfolio{
                        showPortfolioView.toggle()
                    }
                }
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
    HomeView().environmentObject(DeveloperPreview.instance.vm)
        
}
