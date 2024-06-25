// Copyright (c) nami.ai

import SwiftUI

public class ThemeManager: ObservableObject {
    @Published public var selectedTheme: ThemeProtocol = NamiTheme()
    
    public init(selectedTheme: ThemeProtocol) {
        self.selectedTheme = selectedTheme
    }
    
    public func setTheme(_ theme: ThemeProtocol) {
        selectedTheme = theme
    }
}

struct NamiNavBar: ViewModifier {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: themeManager.selectedTheme.headline4]
        UINavigationBar.appearance().titleTextAttributes = [.font: themeManager.selectedTheme.headline4]
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    @EnvironmentObject private var themeManager: ThemeManager
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
    
    public func namiNavBar() -> some View {
        self.modifier(NamiNavBar())
    }
}
