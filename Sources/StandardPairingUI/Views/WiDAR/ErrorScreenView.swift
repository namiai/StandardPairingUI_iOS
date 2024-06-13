// Copyright (c) nami.ai

import NamiSharedUIElements
import SwiftUI
import Tomonari
import I18n

public struct ErrorScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: ErrorScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @ObservedObject var viewModel: ErrorScreen.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Spacer()
                Image("Warning")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(positioningErrorTitle())
                    .font(themeManager.selectedTheme.headline3)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                Text(deviceNotFoundMessage())
                    .font(themeManager.selectedTheme.paragraph1)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .padding(.top, 4)
                Spacer()
            }
            .padding(.top)
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.cancelPositioning)
            }
        } bottomButtonsGroup: {
            VStack {
                Button(retryPositioningButton()) {
                    viewModel.send(.retryPositioning)
                }
                .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                .anyView
                Button(exitPositioningButton()) {
                    viewModel.send(.cancelPositioning)
                }
                .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
                .anyView
            }
            .padding()
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.positioningNavigationTitle {
            return customNavigationTitle
        }
        
        return I18n.Widar.headerTitle
    }
    
    private func positioningErrorTitle() -> String {
        if let customString = wordingManager.wordings.positioningErrorTitle {
            return customString
        }
        
        return I18n.Widar.Error.title
    }
    
    private func deviceNotFoundMessage() -> String {
        if let customString = wordingManager.wordings.deviceNotFoundMessage {
            return customString
        }
        
        return I18n.Widar.Error.deviceNotFoundMessage
    }
    
    private func retryPositioningButton() -> String {
        if let customString = wordingManager.wordings.retryPositioningButton {
            return customString
        }
        
        return I18n.Widar.Error.retryButton
    }
    
    private func exitPositioningButton() -> String {
        if let customString = wordingManager.wordings.exitPositioningButton {
            return customString
        }
        
        return I18n.Widar.Error.exitButton
    }
}
