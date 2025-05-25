//
//  CrypSmartApp.swift
//  CrypSmart
//
//  Created by Arjun Singh on 17/05/25.
//

import SwiftUI

@main
struct CrypSmartApp: App {
    @StateObject var vm=HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView().toolbar(.hidden)
            }
        }.environment(vm)
    }
}
