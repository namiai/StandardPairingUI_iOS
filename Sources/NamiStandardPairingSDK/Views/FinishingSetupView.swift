// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - FinishingSetupView

struct FinishingSetupView: View {

    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NamiChatBubble(I18n.Pairing.FinishingSetup.header.localized)
                    .padding()
                Spacer()
            }
            .padding()

            VStack {
                Spacer()
                PongView()
                    .frame(maxHeight: 300)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
