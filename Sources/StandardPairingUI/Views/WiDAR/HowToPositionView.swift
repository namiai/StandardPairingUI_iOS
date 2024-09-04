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
        DeviceSetupScreen(title: wordingManager.wordings.positioningNavigationTitle) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            Button(wordingManager.wordings.startPositioningButton) {
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
        VStack(alignment: .center) {
            AnimationView(animation: \.widarPositioningRec)
            
            Text(wordingManager.wordings.recommendationsTitle, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
                .padding(.vertical)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image("GreenTick", bundle: .module)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(wordingManager.wordings.recommendationsInfoAttachBase, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
                HStack(alignment: .top) {
                    Image("GreenTick", bundle: .module)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(wordingManager.wordings.recommendationsInfoWireOnBack, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
                HStack(alignment: .top) {
                    Image("GreenTick", bundle: .module)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(wordingManager.wordings.recommendationsInfoKeepAreaClear, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
