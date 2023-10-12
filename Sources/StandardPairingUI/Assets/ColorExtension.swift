// Copyright (c) nami.ai

import SwiftUI
import SharedAssets

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
    
    static let colors = Colors()

    static var accent: Color = colors.accent
    static var headline: Color = colors.headline
    static var bodyText: Color = colors.bodyText
    static var darkText: Color = colors.darkText
    static var primary: Color = colors.primary
    static var linkText: Color = colors.linkText
    static var lowerBackground: Color = colors.lowerBackground
    static var negative: Color = colors.negative
    static var warning: Color = colors.warning
    static var positive: Color = colors.positive
    static var allGood: Color = colors.allGood
    static var borderStroke: Color = colors.borderStroke
    static var graphLines: Color = colors.graphLines
    static var placeholder: Color = colors.placeholder
    static var authButtonStroke: Color = colors.authButtonStroke
    static var buttonedFieldBackground: Color = colors.buttonedFieldBackground
    static var buttonedFieldStroke: Color = colors.buttonedFieldStroke

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
