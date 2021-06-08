//
//  Application.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 08/06/2021.
//

import SwiftUI


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
