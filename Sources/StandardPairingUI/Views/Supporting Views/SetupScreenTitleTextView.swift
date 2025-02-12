// Copyright (c) nami.ai

import SwiftUI
import SharedAssets

// MARK: - ScreenTitleTextView

public struct SetupScreenTitleTextView: View {
    // MARK: Lifecycle

    init(title: String) {
        self.title = title
    }

    // MARK: Internal

    var title: String

    public var body: some View {
        VStack {
            Text(title)
                .font(themeManager.selectedTheme.headline3)
                .lineLimit(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(minWidth: 200)
    }
    
    @Environment(\.themeManager) private var themeManager
}

// MARK: - ScreenTitleTextView_Previews

struct SetupScreenTitleTextView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()

            ScrollView {
                SetupScreenTitleTextView(
                    title: "A place with the long title"
                )
                .frame(height: 200)
                .background(Colors().forTheme(1, saturation: .lite))

                SetupScreenTitleTextView(
                    title: "A place with the long title 2"
                )
                .background(Colors().forTheme(2, saturation: .lite))

                SetupScreenTitleTextView(
                    title: "Home"
                )
                .frame(height: 200)
                .background(Colors().forTheme(3, saturation: .lite))
            }
        }
    }
}
