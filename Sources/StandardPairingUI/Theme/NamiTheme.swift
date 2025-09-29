// Copyright (c) nami.ai

import NamiSharedUIElements
import SharedAssets
import SwiftUI

public struct NamiTheme: ThemeProtocol {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    // Fonts
    public var headline1: Font = NamiTextStyle.headline.font

    public var headline2: Font = NamiTextStyle.headline2.font

    public var headline3: Font = NamiTextStyle.headline3.font

    public var headline4: Font = NamiTextStyle.headline4.font

    public var headline5: Font = NamiTextStyle.headline5.font

    public var headline6: Font = NamiTextStyle.headline6.font

    public var paragraph1: Font = NamiTextStyle.paragraph1.font

    public var paragraph2: Font = NamiTextStyle.paragraph2.font

    public var small1: Font = NamiTextStyle.small.font

    public var small2: Font = NamiTextStyle.small2.font

    // Colors

    public var navigationTitleColor: Color?

    public var navigationBarColor: Color?

    public var primaryActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .primary)

    public var secondaryActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .secondary)

    public var tertiaryActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .tertiary)

    public var destructiveActionButtonStyle: any ButtonStyle = NamiActionButtonStyle(rank: .destructive)
}
