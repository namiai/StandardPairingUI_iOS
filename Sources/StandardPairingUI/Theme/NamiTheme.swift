// Copyright (c) nami.ai

import SwiftUI
import SharedAssets
import NamiSharedUIElements

public struct NamiTheme: ThemeProtocol {
    // Fonts
    public var headline1: Font = NamiTextStyle.headline.font
    
    public var headline2: Font = NamiTextStyle.headline2.font
    
    public var headline3: Font = NamiTextStyle.headline3.font
    
    public var headline4: Font = NamiTextStyle.headline4.font
    
    public var headline5: Font = NamiTextStyle.headline5.font
    
    public var paragraph1: Font = NamiTextStyle.paragraph1.font
    
    public var paragraph2: Font = NamiTextStyle.paragraph2.font
    
    public var small1: Font = NamiTextStyle.small.font
    
    public var small2: Font = NamiTextStyle.small2.font
    
    
    // Colors
    public var primaryBlack: Color = Color.namiColors.neutral.primaryBlack
    
    public var primaryBlackDisabled: Color = Color.namiColors.neutral.primaryBlack
    
    public var secondaryBlack: Color = Color.namiColors.neutral.secondaryBlack
    
    public var tertiaryBlack: Color = Color.namiColors.neutral.tertiaryBlack
    
    public var white: Color = Color.namiColors.neutral.white
    
    public var whiteDisabled: Color = Color.namiColors.neutral.white
    
    public var background: Color = Color.namiColors.neutral.background
    
    public var line: Color = Color.namiColors.neutral.line
    
    public var accent: Color = Color.namiColors.accent
    
    public var headline: Color = Color.namiColors.headline
    
    public var linkText: Color = Color.namiColors.linkText
    
    public var negative: Color = Color.namiColors.negative
    
    public var warning: Color = Color.namiColors.warning
    
    public var warningLight: Color = Color.namiColors.warningLight
    
    public var positive: Color = Color.namiColors.positive
    
    public var allGood: Color = Color.namiColors.allGood
    
    public var placeholder: Color = Color.namiColors.placeholder
    
    public var authButtonStroke: Color = Color.namiColors.authButtonStroke
    
    public var buttonedFieldBackground: Color = Color.namiColors.buttonedFieldBackground
    
    public var buttonedFieldStroke: Color = Color.namiColors.buttonedFieldStroke
    
    public var progressSelected: Color = Color.namiColors.progressSelected
    
    public var lowAttentionAlert: Color = Color.namiColors.lowAttentionAlert
    
    public var lowAttentionAlertLight: Color = Color.namiColors.lowAttentionAlertLight
    
    public var alert1: Color = Color.namiColors.alert1
    
    public var alert2: Color = Color.namiColors.alert2
    
    public var redAlert3: Color = Color.namiColors.redAlert3
    
    public var redAlert4: Color = Color.namiColors.redAlert4
    
    public var success3: Color = Color.namiColors.success3
    
    public var success4: Color = Color.namiColors.success4
    
    public var primaryActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .primary)
    
    public var secondaryActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .secondary)
    
    public var tertiaryActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .tertiary)
    
    public var destructiveActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .destructive)
} 
