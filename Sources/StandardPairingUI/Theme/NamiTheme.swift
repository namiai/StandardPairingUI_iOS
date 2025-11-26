// Copyright (c) nami.ai

import SwiftUI
import NamiSharedUIElements

public struct NamiTheme: ThemeProtocol {

    public init() {

    }

    // Fonts
    public var headline1: Font = NamiSharedUIElements.NamiTextStyle.headline.font

    public var headline2: Font = NamiSharedUIElements.NamiTextStyle.headline2.font

    public var headline3: Font = NamiSharedUIElements.NamiTextStyle.headline3.font

    public var headline4: Font = NamiSharedUIElements.NamiTextStyle.headline4.font

    public var headline5: Font = NamiSharedUIElements.NamiTextStyle.headline5.font

    public var headline6: Font = NamiSharedUIElements.NamiTextStyle.headline6.font

    public var paragraph1: Font = NamiSharedUIElements.NamiTextStyle.paragraph1.font

    public var paragraph2: Font = NamiSharedUIElements.NamiTextStyle.paragraph2.font

    public var small1: Font = NamiSharedUIElements.NamiTextStyle.small.font

    public var small2: Font = NamiSharedUIElements.NamiTextStyle.small2.font


    // Colors

    public var navigationTitleColor: Color? = nil

    public var navigationBarColor: Color? = nil

    public var primaryActionButtonStyle: any ButtonStyle = NamiSharedUIElements.NamiActionButtonStyle(rank: .primary)

    public var secondaryActionButtonStyle: any ButtonStyle = NamiSharedUIElements.NamiActionButtonStyle(rank: .secondary)

    public var tertiaryActionButtonStyle: any ButtonStyle = NamiSharedUIElements.NamiActionButtonStyle(rank: .tertiary)

    public var destructiveActionButtonStyle: any ButtonStyle = NamiSharedUIElements.NamiActionButtonStyle(rank: .destructive)
} 
