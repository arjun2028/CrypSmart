//
//  Double.swift
//  CrypSmart
//
//  Created by Arjun Singh on 19/05/25.
//

import Foundation

extension Double{
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- default value
        //formatter.currencyCode = "usd" // <- change currency
        //formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrenctWith2Decimal()->String{
        let Number=NSNumber(value: self)
        return currencyFormatter2.string(from: Number) ?? "$0.00"
    }
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- default value
        //formatter.currencyCode = "usd" // <- change currency
        //formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrenctWith6Decimal()->String{
        let Number=NSNumber(value: self)
        return currencyFormatter6.string(from: Number) ?? "$0.00"
    }
    
    func asNumberString()->String{
        return String(format: "%.2f", self)
    }
    
    func asPercentString()->String{
        return asNumberString()+"%"
    }
    
}
