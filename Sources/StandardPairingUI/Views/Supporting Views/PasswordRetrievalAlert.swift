// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

extension View {
    @ViewBuilder
    func passwordRetrievalAlert(isPresented: Binding<Bool>, networkName: String, viewModel: any StoredPasswordRetrievingViewModel, wordingManager: WordingManager) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text(wordingManager.wordings.foundSavedPassword),
                message: Text(wordingManager.wordings.useSavedPassword(networkName: networkName)),
                primaryButton:
                .destructive(
                    Text(wordingManager.wordings.forget),
                    action: {
                        viewModel.forgetPassword()
                    }
                ),
                secondaryButton:
                .default(
                    Text(wordingManager.wordings.ok),
                    action: { viewModel.usePassword()
                    }
                )
            )
        }
    }
}
