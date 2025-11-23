// Copyright (c) nami.ai

import SwiftUI
import NamiPairingFramework

public struct NamiTheme: ThemeProtocol {

    public init() {

    }

    // Fonts
    public var headline1: Font = NamiPairingFramework.NamiTextStyle.headline.font

    public var headline2: Font = NamiPairingFramework.NamiTextStyle.headline2.font

    public var headline3: Font = NamiPairingFramework.NamiTextStyle.headline3.font

    public var headline4: Font = NamiPairingFramework.NamiTextStyle.headline4.font

    public var headline5: Font = NamiPairingFramework.NamiTextStyle.headline5.font

    public var headline6: Font = NamiPairingFramework.NamiTextStyle.headline6.font

    public var paragraph1: Font = NamiPairingFramework.NamiTextStyle.paragraph1.font

    public var paragraph2: Font = NamiPairingFramework.NamiTextStyle.paragraph2.font

    public var small1: Font = NamiPairingFramework.NamiTextStyle.small.font

    public var small2: Font = NamiPairingFramework.NamiTextStyle.small2.font


    // Colors

    public var navigationTitleColor: Color? = nil

    public var navigationBarColor: Color? = nil

    public var primaryActionButtonStyle: any ButtonStyle = NamiPairingFramework.NamiActionButtonStyle(rank: .primary)

    public var secondaryActionButtonStyle: any ButtonStyle = NamiPairingFramework.NamiActionButtonStyle(rank: .secondary)

    public var tertiaryActionButtonStyle: any ButtonStyle = NamiPairingFramework.NamiActionButtonStyle(rank: .tertiary)

    public var destructiveActionButtonStyle: any ButtonStyle = NamiPairingFramework.NamiActionButtonStyle(rank: .destructive)
} 
