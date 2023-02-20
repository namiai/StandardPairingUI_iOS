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
    
    static var accent: Color { Color("AccentColor", bundle: .module) }
    static var headline: Color { Color("Headline", bundle: .module) }
    static var bodyText: Color { Color("BodyText", bundle: .module) }
    static var darkText: Color { Color("DarkText", bundle: .module) }
    static var primary: Color { Color("Primary", bundle: .module) }
    static var onPrimary: Color { Color("OnPrimary", bundle: .module) }
    static var linkText: Color { Color("LinkText", bundle: .module) }
    static var lowerBackground: Color { Color("LowerBackground", bundle: .module) }
    static var negative: Color { Color("Negative", bundle: .module) }
    static var warning: Color { Color("Warning", bundle: .module) }
    static var positive: Color { Color("Positive", bundle: .module) }
    static var allGood: Color { Color("AllGood", bundle: .module) }
    static var borderStroke: Color { Color("BorderStroke", bundle: .module) }
    static var graphLines: Color { Color("GraphLines", bundle: .module) }
    static var placeholder: Color { Color("Placeholder", bundle: .module) }
    static var authButtonStroke: Color { Color("AuthButtonStroke", bundle: .module) }
    static var profileTileBackground: Color { Color("ProfileTileBackground", bundle: .module) }
    static var buttonedFieldBackground: Color { Color("ButtonedFieldBackground", bundle: .module) }
    static var buttonedFieldStroke: Color { Color("ButtonedFieldStroke", bundle: .module) }
    
    static var systemBackground: Self {
        Color(UIColor.systemBackground)
    }

    static var textLabel: Self {
        Color(UIColor.label)
    }

    static var invertedTextLabel: Self {
        UITraitCollection.current.userInterfaceStyle == .dark ? Color(UIColor.darkText) : Color(UIColor.lightText)
    }

    static var tint: Self {
        Color(UIView().tintColor)
    }
}
