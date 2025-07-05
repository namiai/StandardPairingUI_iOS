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
    
    var primaryBlack: Color { get }
    var secondaryBlack: Color { get }
    var tertiaryBlack: Color { get }
    var navigationTitleColor: Color { get }
    var white: Color { get }
    var background: Color { get }
    var line: Color { get }
    var accent: Color { get }
    var negative: Color { get }
    var warning: Color { get }
    var positive: Color { get }
    var lowAttentionAlert: Color { get }

    var redAlert3: Color { get }
    var redAlert4: Color { get }
    var success3: Color { get }
    var success4: Color { get }
    
    @MainActor var primaryActionButtonStyle: any ButtonStyle { get }
    @MainActor var secondaryActionButtonStyle: any ButtonStyle { get }
    @MainActor var tertiaryActionButtonStyle: any ButtonStyle { get }
    @MainActor var destructiveActionButtonStyle: any ButtonStyle { get }
}
