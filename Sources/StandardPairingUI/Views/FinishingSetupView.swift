// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - FinishingSetupView

public struct FinishingSetupView: View {
    
    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.FinishingSetup.header.localized)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Fancy a game of pong?")
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 4)
                Spacer()
                PongView()
                    .frame(maxHeight: 300)
                    .padding()
            }
            .padding()
        }
    }
}
