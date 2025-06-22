//
//  SearchBar.swift
//  CrypSmart
//
//  Created by Arjun Singh on 20/06/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText:String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.secondaryText)
            TextField("Please search here ...", text: $searchText)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundStyle(Color.theme.ascent)
                        .opacity(searchText.isEmpty ? 0:1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText=""
                             
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.ascent.opacity(0.15), radius: 10,x:0,y: 0)
        )
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
