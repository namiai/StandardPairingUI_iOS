//
//  File.swift
//  
//
//  Created by Yachin Ilya on 14.02.2023.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 08) & 0xFF) / 255.0,
            blue: Double((hex >> 00) & 0xFF) / 255.0,
            opacity: alpha
        )
    }
    
    static var lowerBackground: Self {
        UITraitCollection.current.userInterfaceStyle == .dark ?
        Color(hex: 0x000000) :
        Color(hex: 0xF8F8F8)
    }
}
