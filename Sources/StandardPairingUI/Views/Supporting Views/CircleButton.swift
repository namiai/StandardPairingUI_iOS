// Copyright (c) nami.ai

import SwiftUI

public struct CircleButton: View {
    // MARK: Public

    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(backgroundColor)

            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(foregroundColor)
                // Hack to maximize the similarity to chevron image asset.
                // SVG has preset 4 px paddings.
                .padding(9)
        }
    }

    // MARK: Private

    private let image = Image(systemName: "chevron.backward")
    private let foregroundColor = Color.black
    private let backgroundColor = Color(UIColor.systemBackground)
}
