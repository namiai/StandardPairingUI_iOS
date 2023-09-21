// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

extension View {
    @ViewBuilder
    func passwordRetrievalAlert(isPresented: Binding<Bool>, networkName: String, viewModel: any StoredPasswordRetrievingViewModel) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text(I18n.Pairing.ListWiFiNetworks.foundSavedPassword.localized),
                message: Text(I18n.Pairing.ListWiFiNetworks.useSavedPassword.localized(with: networkName)),
                primaryButton:
                .destructive(Text(I18n.Pairing.ListWiFiNetworks.forget.localized), action: { viewModel.forgetPassword() }),
                secondaryButton:
                .default(Text(I18n.General.OK.localized), action: { viewModel.usePassword() })
            )
        }
    }
}
