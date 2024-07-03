// Copyright (c) nami.ai

import Lottie
import SharedAssets
import SwiftUI
import Tomonari
import I18n
import NamiSharedUIElements

public struct HowToPositionView: View {
    // MARK: Lifecycle

    public init(viewModel: HowToPosition.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations

    @ObservedObject var viewModel: HowToPosition.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            Button(startPositioningButton()) {
                viewModel.send(.startPositioningTapped)
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
            AnimationView(animation: \.widarPositioningRec)

            Text(recommendationsTitle(), font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
            Text("∙ \(recommendationsInfoAttachBase())", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(recommendationsInfoWireOnBack())", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(recommendationsInfoKeepAreaClear())", font: themeManager.selectedTheme.paragraph1).fillWidth()

            Spacer()
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.positioningNavigationTitle {
            return customNavigationTitle
        }
        
        return I18n.Widar.headerTitle
    }
    
    private func recommendationsTitle() -> String {
        if let customScanning = wordingManager.wordings.recommendationsTitle {
            return customScanning
        }
        
        return I18n.Widar.Recommendations.title
    }
    
    private func recommendationsInfoAttachBase() -> String {
        if let customString = wordingManager.wordings.recommendationsInfoAttachBase {
            return customString
        }
        
        return I18n.Widar.Recommendations.infoAttachBase
    }
    
    private func recommendationsInfoWireOnBack() -> String {
        if let customString = wordingManager.wordings.recommendationsInfoWireOnBack {
            return customString
        }
        
        return I18n.Widar.Recommendations.infoWireOnBack
    }
    
    private func recommendationsInfoKeepAreaClear() -> String {
        if let customString = wordingManager.wordings.recommendationsInfoKeepAreaClear {
            return customString
        }
        
        return I18n.Widar.Recommendations.infoKeepAreaClear
    }
    
    private func startPositioningButton() -> String {
        if let customString = wordingManager.wordings.startPositioningButton {
            return customString
        }
        
        return I18n.Widar.Recommendations.buttonText
    }
}
