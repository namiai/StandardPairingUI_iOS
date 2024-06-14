// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

extension View {    
    @ViewBuilder
    func passwordRetrievalAlert(isPresented: Binding<Bool>, networkName: String, viewModel: any StoredPasswordRetrievingViewModel, wordingManager: WordingManager) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text(wordingManager.wordings.foundSavedPassword != nil ? wordingManager.wordings.foundSavedPassword! : I18n.Pairing.ListWifiNetworks.foundSavedPassword),
                message: Text(wordingManager.wordings.useSavedPassword != nil ? String.localizedStringWithFormat(wordingManager.wordings.useSavedPassword!, networkName) :  I18n.Pairing.ListWifiNetworks.useSavedPassword(networkName)),
                primaryButton:
                .destructive(
                    Text(wordingManager.wordings.forget != nil ? wordingManager.wordings.forget! : I18n.Pairing.ListWifiNetworks.forget), 
                    action: { 
                        viewModel.forgetPassword() 
                    }
                ),
                secondaryButton:
                .default(
                    Text(wordingManager.wordings.ok != nil ? wordingManager.wordings.ok! : I18n.General.ok), 
                    action: { viewModel.usePassword() 
                    }
                )
            )
        }
    }
}
