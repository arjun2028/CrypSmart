//
//  PortfolioView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 26/06/25.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel?
    @State private var quantityText:String=""
    @State private var showCheckMark:Bool=false
    
    private func getCurrentValue()->Double{
        if let quantity=Double(quantityText){
            return quantity*(selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveCheckButton(){
        
        guard let coin=selectedCoin else{
            return
        }
        
        
        //save animation
        
        withAnimation(.easeIn){
            showCheckMark=true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
            withAnimation(.easeOut){
                showCheckMark=false
            }
        }
        
       
    }
    
    private func removeSelectedCoin(){
        selectedCoin=nil
        vm.searchText=""
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(searchText: $vm.searchText)
                    coinLogoList
                    
                    if let coin = selectedCoin {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Current price of \(coin.symbol.uppercased()): \(coin.currentPrice.asCurrenctWith6Decimal())").padding()
                                
                            }
                            Divider()
                            
                            HStack{
                                Text("Amount in your portfolio :")
                                Spacer()
                                TextField("Ex 1.4", text: $quantityText)
                                    .foregroundStyle(.red)
                                    .multilineTextAlignment(.trailing).keyboardType(.decimalPad)
                            }
                            Divider()
                            HStack{
                                Text("Current Value :")
                                Spacer()
                                Text(getCurrentValue().asCurrenctWith2Decimal())
                            }
                        }.font(.headline).padding()
                    }

                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack {
                        Image(systemName: "checkmark")
                           .opacity(showCheckMark ? 1 : 0)

                        Button {
                            // Action here
                            saveCheckButton()
                        } label: {
                            Text("SAVE")
                        }.opacity(
                            (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1 : 0)
                    }
                    .onChange(of: vm.searchText, initial: true){
                        if vm.searchText==""{
                            removeSelectedCoin()
                        }
                    }
                    


                    
                    

                    
                }
            }
        }
    }

    // Extracted horizontal coin logo list as computed property
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 13) {
                ForEach(vm.allcoins) { coin in
                    CoinLogoItem(
                        coin: coin,
                        isSelected: coin.id == selectedCoin?.id,
                        onSelect: { selectedCoin = coin }
                    )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
}

// Extracted single Coin item into its own View
private struct CoinLogoItem: View {
    let coin: CoinModel
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.theme.green : Color.clear, lineWidth: 1)
            )
            .onTapGesture {
                onSelect()
            }
    }
}


#Preview {
    PortfolioView().environmentObject(DeveloperPreview.instance.vm)
}
