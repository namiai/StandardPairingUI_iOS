// Copyright (c) nami.ai

import SwiftUI

// MARK: - ThemeManager

public class ThemeManager: ObservableObject {
    // MARK: Lifecycle

    public init(selectedTheme: ThemeProtocol) {
        self.selectedTheme = selectedTheme
    }

    // MARK: Public

    @Published public var selectedTheme: ThemeProtocol = NamiTheme()

    public func setTheme(_ theme: ThemeProtocol) {
        selectedTheme = theme
    }

    // MARK: Internal

    static var namiDefault: ThemeManager { ThemeManager(selectedTheme: NamiTheme()) }
}

// MARK: - ThemeManagerKey

private struct ThemeManagerKey: EnvironmentKey {
    static let defaultValue: ThemeManager = .namiDefault
}

public extension EnvironmentValues {
    var themeManager: ThemeManager {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
}

// MARK: - NamiNavBar

struct NamiNavBar: ViewModifier {
    // MARK: Lifecycle

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: themeManager.selectedTheme.headline4]
        UINavigationBar.appearance().titleTextAttributes = [.font: themeManager.selectedTheme.headline4]
    }

    // MARK: Internal

    func body(content: Content) -> some View {
        content
    }

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }

    public func namiNavBar() -> some View {
        modifier(NamiNavBar())
    }
}
