//
//  KPIView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 22/06/25.
//

import SwiftUI

struct KPIView: View {
    let stat:KPIModel
    var body: some View {
        VStack{
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.ascent)
            
            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentChange ?? 0) >= 0 ? 0 : 180))
                    .opacity(stat.percentChange != nil ? 1 : 0)


                Text(stat.percentChange?.asPercentString() ?? "").font(.caption).bold()
            }
            .foregroundStyle((stat.percentChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)

        }
    }
}

#Preview {
    KPIView(stat: KPIModel(title: "Net Value", value: "12bn", percentChange: 22.31))
}
