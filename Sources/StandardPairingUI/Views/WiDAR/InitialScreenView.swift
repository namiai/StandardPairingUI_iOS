// Copyright (c) nami.ai

import Lottie
import SharedAssets
import SwiftUI
import Tomonari
import I18n
import NamiSharedUIElements

public struct InitialScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: InitialScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @ObservedObject var viewModel: InitialScreen.ViewModel
    @Environment(\.colors) var colors: Colors
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            mainContent()
                .padding(.horizontal)
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.dismissSelf)
            }
        } bottomButtonsGroup: {
            Button(nextButtonText()) {
                viewModel.send(.howToPositionTapped)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            Text(widarInfoMustOptimisePosition(), font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
            Text("∙ \(widarInfoMustOptimisePosition())", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(widarInfoAvoidMovingWhenOptimized())", font: themeManager.selectedTheme.paragraph1).fillWidth().foregroundColor(themeManager.selectedTheme.redAlert4)
            Spacer()
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.positioningNavigationTitle {
            return customNavigationTitle
        }
        
        return I18n.widarHeaderTitle
    }
    
    private func widarInfoTitle() -> String {
        if let customString = wordingManager.wordings.widarInfoTitle {
            return customString
        }
        
        return I18n.widarInfoTitle
    }
    
    private func widarInfoMustOptimisePosition() -> String {
        if let customString = wordingManager.wordings.widarInfoMustOptimisePosition {
            return customString
        }
        
        return I18n.widarInfoInfoMustOptimisePosition
    }
    
    private func widarInfoAvoidMovingWhenOptimized() -> String {
        if let customString = wordingManager.wordings.widarInfoAvoidMovingWhenOptimized {
            return customString
        }
        
        return I18n.widarInfoInfoAvoidMovingWhenOptimized
    }
    
    private func nextButtonText() -> String {
        if let customString = wordingManager.wordings.nextButton {
            return customString
        }
        
        return I18n.generalNext
    }
}
