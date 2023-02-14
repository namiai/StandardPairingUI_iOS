// Copyright (c) nami.ai

import SwiftUI

// MARK: - NamiErrorChatBubble

struct NamiErrorChatBubble: View {
    // MARK: Lifecycle

    init(_ text: String) {
        self.text = text
    }

    // MARK: Internal

    @Environment(\.images) var images: Images

    var text: String

    var body: some View {
        RoundedRectContainerView(excludingCorners: .topLeft, backgroundColor: Color.white) {
            HStack(alignment: .firstTextBaseline) {
                errorIndicator()
                Text(text)
                    .multilineTextAlignment(.leading)
                    .font(NamiTextStyle.headline4.font)
                Spacer()
            }
            .padding()
        }
    }

    // MARK: Private

    private func errorIndicator() -> some View {
        VStack {
            Image(images.errorIndicator)
                .offset(y: 6)
        }
    }
}

// MARK: - NamiErrorChatBubble_Previews

struct NamiErrorChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            VStack {
                VStack {
                    NamiErrorChatBubble("The first thing to know is that there’s many things you can do with nami. So please take your time to check them all out.")
                    NamiErrorChatBubble("Hello, World!")
                }
                VStack {
                    NamiErrorChatBubble("The first thing to know is that there’s many things you can do with nami. So please take your time to check them all out.")
                    NamiErrorChatBubble("Hello, World!")
                }
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            }
        }
        .previewLayout(.fixed(width: 320, height: 740))
    }
}
