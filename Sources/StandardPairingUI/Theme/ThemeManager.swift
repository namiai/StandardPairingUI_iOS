// Copyright (c) nami.ai

import SwiftUI
import Combine

public class ThemeManager: ObservableObject {
    @Published public var selectedTheme: ThemeProtocol = NamiTheme()
    
    public init(selectedTheme: ThemeProtocol) {
        self.selectedTheme = selectedTheme
    }
    
    public func setTheme(_ theme: ThemeProtocol) {
        selectedTheme = theme
    }
    
    internal static var namiDefault: ThemeManager { ThemeManager(selectedTheme: NamiTheme()) }
}

private struct ThemeManagerKey: EnvironmentKey {
    nonisolated(unsafe) static let defaultValue: ThemeManager = .namiDefault
}

public extension EnvironmentValues {
    var themeManager: ThemeManager {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
}

struct NamiNavBar: ViewModifier {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: (themeManager).selectedTheme.headline4]
        UINavigationBar.appearance().titleTextAttributes = [.font: (themeManager).selectedTheme.headline4]
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    @Environment(\.themeManager) private var themeManager
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
    
    public func namiNavBar() -> some View {
        self.modifier(NamiNavBar())
    }
}
