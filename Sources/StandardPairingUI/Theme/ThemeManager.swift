// Copyright (c) nami.ai

import SwiftUI

public class ThemeManager: ObservableObject {
    @Published var selectedTheme: ThemeProtocol = NamiTheme()
    
    public init(selectedTheme: ThemeProtocol) {
        self.selectedTheme = selectedTheme
    }
    
    public func setTheme(_ theme: ThemeProtocol) {
        selectedTheme = theme
    }
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}
