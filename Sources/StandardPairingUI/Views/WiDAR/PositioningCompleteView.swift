// Copyright (c) nami.ai

import SwiftUI
import Tomonari
import I18n
import NamiSharedUIElements

public struct PositioningCompleteView: View {
    // MARK: Lifecycle

    public init(viewModel: PositioningComplete.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations

    @ObservedObject var viewModel: PositioningComplete.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                VStack {
                    AnimationView(animation: \.widarPositioningDone)
                        .padding(.vertical)
                    Text(successTitle(), font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
                    Text(sucessContentMessage(), font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                }
                .padding(.horizontal)

                Spacer()
            }
        } bottomButtonsGroup: {
            Button(doneButton()) {
                viewModel.send(.confirmPositioningComplete)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.positioningNavigationTitle {
            return customNavigationTitle
        }
        
        return I18n.Widar.headerTitle
    }
    
    private func successTitle() -> String {
        if let customString = wordingManager.wordings.successTitle {
            return customString
        }
        
        return I18n.Widar.Success.title
    }
    
    private func sucessContentMessage() -> String {
        if let customString = wordingManager.wordings.sucessContentMessage {
            return String.localizedStringWithFormat(customString, viewModel.state.deviceName)
        }
        
        return I18n.Widar.Success.contentMessage(viewModel.state.deviceName)
    }
    
    private func doneButton() -> String {
        if let customString = wordingManager.wordings.doneButton {
            return customString
        }
        
        return I18n.Widar.Success.doneButton
    }
}
