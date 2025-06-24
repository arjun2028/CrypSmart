//
//  HomeStatsView.swift
//  CrypSmart
//
//  Created by Arjun Singh on 24/06/25.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm:HomeViewModel
    @Binding var showPortfolio:Bool
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                KPIView(stat: stat).frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false)).environmentObject(DeveloperPreview.instance.vm)
}
