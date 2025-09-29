// Copyright (c) nami.ai

import SwiftUI

public protocol ThemeProtocol {
    var headline1: Font { get }
    var headline2: Font { get }
    var headline3: Font { get }
    var headline4: Font { get }
    var headline5: Font { get }
    var headline6: Font { get }

    var paragraph1: Font { get }
    var paragraph2: Font { get }

    var small1: Font { get }
    var small2: Font { get }

    // Only used for color overrides. Otherwise the defaults from Colors environment are used.
    var navigationTitleColor: Color? { get }
    var navigationBarColor: Color? { get }

    var primaryActionButtonStyle: any ButtonStyle { get }
    var secondaryActionButtonStyle: any ButtonStyle { get }
    var tertiaryActionButtonStyle: any ButtonStyle { get }
    var destructiveActionButtonStyle: any ButtonStyle { get }
}
