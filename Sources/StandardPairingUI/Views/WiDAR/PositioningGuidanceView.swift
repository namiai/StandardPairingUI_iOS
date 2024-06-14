// Copyright (c) nami.ai

import SwiftUI
import BottomSheet
import SharedAssets
import CommonTypes
import Tomonari
import I18n
import NamiSharedUIElements

public struct PositioningGuidanceView: View {
    // MARK: Lifecycle

    public init(viewModel: PositioningGuidance.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations
    @Environment(\.colors) var colors: Colors
    @Environment(\.measurementSystem) var measurementSystem: MeasurementSystem
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    @ObservedObject var viewModel: PositioningGuidance.ViewModel

    public var body: some View {
        let cancelSheetBinding = Binding {
            viewModel.state.wantCancel
        } set: { wantCancel in
            if wantCancel == false {
                viewModel.send(.cancelViewDismissed)
            }
        }

        DeviceSetupScreen(title: titleWording()) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            VStack {
                Button(finishButtonText()) {
                    viewModel.send(.wantFinishTapped)
                }
                .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                .disabled(viewModel.state.canNotFinish)
                .anyView

                Button(cancelButtonText()) {
                    viewModel.send(.wantCancelTapped)
                }
                .buttonStyle(themeManager.selectedTheme.tertiaryActionButtonStyle)
                .disabled(viewModel.state.canNotCancel)
                .anyView
            }
            .padding(.vertical)
        }
        .bottomSheet(isPresented: cancelSheetBinding, height: 316, showTopIndicator: false) {
            sheetContent()
        }
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            Text(positionGuidanceTitle())
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom])
            
            switch measurementSystem {
            case .metric:
                Text(guideMetric(), font: themeManager.selectedTheme.paragraph1).fillWidth()
            case .uk:
                Text(guideImperial(), font: themeManager.selectedTheme.paragraph1).fillWidth()
            case .us:
                Text(guideImperial(), font: themeManager.selectedTheme.paragraph1).fillWidth()
            }
            

            let quality = viewModel.state.positioningQuality

            switch quality {
            case .degraded,
                 .poor,
                 .unknown:
                AnimationView(animation: \.widarPositioningExample)
                    .padding(.vertical)
            case .good:
                AnimationView(animation: \.widarPositioningOptimised)
                    .padding(.vertical)
            }

            RoundedRectContainerView {
                VStack {
                    Text(statusLabel(), font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                    if viewModel.state.positioningState == .started {
                        HStack {
                            switch quality {
                            case .unknown:
                                ProgressView().frame(width: 16, height: 16)
                                Text(statusChecking(), font: themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.tertiaryBlack)
                            case .poor:
                                Circle().fill(Color.red).frame(width: 16, height: 16)
                                Text(statusMispositioned(), font: themeManager.selectedTheme.headline5).foregroundColor(colors.redAlert4)
                            case .degraded:
                                Circle().fill(Color.yellow).frame(width: 16, height: 16)
                                Text(statusGettingBetter(), font: themeManager.selectedTheme.headline5).foregroundColor(colors.lowAttentionAlert)
                            case .good:
                                Circle().fill(Color.green).frame(width: 16, height: 16)
                                Text(statusOptimized(), font: themeManager.selectedTheme.headline5).foregroundColor(colors.success4)
                            }
                        }
                    } else {
                        HStack {
                            ProgressView().frame(width: 16, height: 16)
                            Text(statusEstablishingConnection(), font: themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.tertiaryBlack)
                        }
                    }
                }
                .padding()
            }

            VStack {
                if quality == .degraded {
                    // TODO: Add this string to POEditor!
                    Text(positioningTip(), font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                }
            }
            .frame(height: 20)

            Spacer()
        }
    }

    private func sheetContent() -> some View {
        VStack {
            Text(cancelPopupTitle())
                .font(themeManager.selectedTheme.headline4)
            Text(cancelPopupMessage())
                .font(themeManager.selectedTheme.paragraph1)
                .padding()
            Button(cancelPopupBackToPositioningButton()) {
                viewModel.send(.cancelViewDismissed)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .anyView
            Button(cancelPopupCancelButton()) {
                viewModel.send(.confirmPositioningCancel)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
            .anyView
            
        }
        .padding(.bottom, 16)
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.positioningNavigationTitle {
            return customNavigationTitle
        }
        
        return I18n.Widar.headerTitle
    }
    
    private func finishButtonText() -> String {
        if let customString = wordingManager.wordings.finishButton {
            return customString
        }
        
        return I18n.Widar.Position.finishButton
    }
    
    private func cancelButtonText() -> String {
        if let customString = wordingManager.wordings.cancelButton {
            return customString
        }
        
        return I18n.Widar.Position.cancelButton
    }
    
    private func positionGuidanceTitle() -> String {
        if let customString = wordingManager.wordings.positioningGuidanceTitle {
            return customString
        }
        
        return I18n.Widar.Position.title
    }
    
    private func guideMetric() -> String {
        if let customString = wordingManager.wordings.guideMetric {
            return customString
        }
        
        return I18n.Widar.Position.guideMetric
    }
    
    private func guideImperial() -> String {
        if let customString = wordingManager.wordings.guideImperial {
            return customString
        }
        
        return I18n.Widar.Position.guideImperial
    }
    
    private func statusLabel() -> String {
        if let customString = wordingManager.wordings.statusLabel {
            return customString
        }
        
        return I18n.Widar.Position.statusLabel
    }
    
    private func statusChecking() -> String {
        if let customString = wordingManager.wordings.statusChecking {
            return customString
        }
        
        return I18n.Widar.Position.statusChecking
    }
    
    private func statusMispositioned() -> String {
        if let customString = wordingManager.wordings.statusMispositioned {
            return customString
        }
        
        return I18n.Widar.Position.statusMispositioned
    }
    
    private func statusGettingBetter() -> String {
        if let customString = wordingManager.wordings.statusGettingBetter {
            return customString
        }
        
        return I18n.Widar.Position.statusGettingBetter
    }
    
    private func statusOptimized() -> String {
        if let customString = wordingManager.wordings.statusOptimized {
            return customString
        }
        
        return I18n.Widar.Position.statusOptimized
    }
    
    private func statusEstablishingConnection() -> String {
        if let customString = wordingManager.wordings.statusEstablishingConnection {
            return customString
        }
        
        return "Establishing connection"
    }
    
    private func positioningTip() -> String {
        if let customString = wordingManager.wordings.positioningTip {
            return customString
        }
        
        return I18n.Widar.Position.guideMetric
    }
    
    private func cancelPopupTitle() -> String {
        if let customString = wordingManager.wordings.cancelPopupTitle {
            return customString
        }
        
        return I18n.Widar.CancelPopup.title
    }
    
    private func cancelPopupMessage() -> String {
        if let customString = wordingManager.wordings.cancelPopupMessage {
            return customString
        }
        
        return I18n.Widar.CancelPopup.message
    }
    
    private func cancelPopupBackToPositioningButton() -> String {
        if let customString = wordingManager.wordings.cancelPopupBackToPositioningButton {
            return customString
        }
        
        return I18n.Widar.CancelPopup.backToPositioningButton
    }
    
    private func cancelPopupCancelButton() -> String {
        if let customString = wordingManager.wordings.cancelPopupCancelButton {
            return customString
        }
        
        return I18n.Widar.CancelPopup.cancelButton
    }
}
