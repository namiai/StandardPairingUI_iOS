// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

extension View {    
    @ViewBuilder
    func passwordRetrievalAlert(isPresented: Binding<Bool>, networkName: String, viewModel: any StoredPasswordRetrievingViewModel, wordingManager: WordingManager) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text(wordingManager.wordings.foundSavedPassword != nil ? wordingManager.wordings.foundSavedPassword! : I18n.pairingListWifiNetworksFoundSavedPassword),
                message: Text(wordingManager.wordings.useSavedPassword != nil ? String.localizedStringWithFormat(wordingManager.wordings.useSavedPassword!, networkName) :  I18n.pairingListWifiNetworksUseSavedPassword(networkName)),
                primaryButton:
                .destructive(
                    Text(wordingManager.wordings.forget != nil ? wordingManager.wordings.forget! : I18n.pairingListWifiNetworksForget), 
                    action: { 
                        viewModel.forgetPassword() 
                    }
                ),
                secondaryButton:
                .default(
                    Text(wordingManager.wordings.ok != nil ? wordingManager.wordings.ok! : I18n.generalOk), 
                    action: { viewModel.usePassword() 
                    }
                )
            )
        }
    }
}
