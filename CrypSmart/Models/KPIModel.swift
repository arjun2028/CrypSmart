//
//  KPIModel.swift
//  CrypSmart
//
//  Created by Arjun Singh on 22/06/25.
//

import Foundation

struct KPIModel:Identifiable{
    let id = UUID()
    let title:String
    let value:String
    let percentChange:Double?
    
    init(title: String, value: String, percentChange: Double?=nil) {
        self.title = title
        self.value = value
        self.percentChange = percentChange
    }
}


//let newModel=KPIModel(title: <#T##String#>, value: <#T##String#>, percentChange: <#T##Double#>)
