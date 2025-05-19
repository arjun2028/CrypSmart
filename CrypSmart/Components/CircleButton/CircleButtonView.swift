//
//  CircleButtonView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 19/05/25.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName:String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.ascent)
            .frame(width: 50,height: 50)
            .background(Circle().foregroundStyle(Color.theme.background))
            .shadow(color:Color.theme.ascent.opacity(0.25), radius: 10)
            .padding()
    }
}

#Preview {
    CircleButtonView(iconName: "info").previewLayout(.sizeThatFits)
}
