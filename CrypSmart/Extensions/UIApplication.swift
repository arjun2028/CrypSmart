//
//  Untitled.swift
//  CrypSmart
//
//  Created by Arjun Singh on 22/06/25.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil )
    }
}
