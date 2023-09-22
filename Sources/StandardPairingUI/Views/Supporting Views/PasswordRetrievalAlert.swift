// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

extension View {
    @ViewBuilder
    func passwordRetrievalAlert(isPresented: Binding<Bool>, networkName: String, viewModel: any StoredPasswordRetrievingViewModel) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text(I18n.Pairing.ListWifiNetworks.foundSavedPassword),
                message: Text(I18n.Pairing.ListWifiNetworks.useSavedPassword( networkName)),
                primaryButton:
                .destructive(Text(I18n.Pairing.ListWifiNetworks.forget), action: { viewModel.forgetPassword() }),
                secondaryButton:
                        .default(Text(I18n.General.ok), action: { viewModel.usePassword() })
            )
        }
    }
}
