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

        DeviceSetupScreen(title: wordingManager.wordings.positioningNavigationTitle) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            VStack {
                Button(wordingManager.wordings.finishButton) {
                    viewModel.send(.wantFinishTapped)
                }
                .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                .disabled(viewModel.state.canNotFinish)
                .anyView

                Button(wordingManager.wordings.cancelButton) {
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
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            Text(wordingManager.wordings.positioningGuidanceTitle)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom])
            
            switch measurementSystem {
            case .metric:
                Text(wordingManager.wordings.guideMetric, font: themeManager.selectedTheme.paragraph1).fillWidth()
            case .uk:
                Text(wordingManager.wordings.guideImperial, font: themeManager.selectedTheme.paragraph1).fillWidth()
            case .us:
                Text(wordingManager.wordings.guideImperial, font: themeManager.selectedTheme.paragraph1).fillWidth()
            }
            

            let quality = viewModel.state.positioningQuality

            WaveformPlot(dataPoints: viewModel.state.losMotionStats.map({ stat in Double(stat)}), strokeColor: .secondary).padding()
        
//            switch quality {
//            case .degraded,
//                 .poor,
//                 .unknown:
//                AnimationView(animation: \.widarPositioningExample)
//                    .padding(.vertical)
//            case .good:
//                AnimationView(animation: \.widarPositioningOptimised)
//                    .padding(.vertical)
//            }
//
            RoundedRectContainerView {
                VStack {
                    Text(wordingManager.wordings.statusLabel, font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                    if viewModel.state.positioningState == .started {
                        HStack {
                            switch quality {
                            case .unknown:
                                ProgressView().frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusChecking, font: themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.tertiaryBlack)
                            case .poor:
                                Circle().fill(Color.red).frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusMispositioned, font: themeManager.selectedTheme.headline5).foregroundColor(colors.redAlert4)
                            case .degraded:
                                Circle().fill(Color.yellow).frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusGettingBetter, font: themeManager.selectedTheme.headline5).foregroundColor(colors.lowAttentionAlert)
                            case .good:
                                Circle().fill(Color.green).frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusOptimized, font: themeManager.selectedTheme.headline5).foregroundColor(colors.success4)
                            }
                        }
                        if let rssi = viewModel.state.rssiValue {
                            Text("RSSI value: \(rssi)", font:themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.primaryBlackDisabled)
                        }
                        
                    } else {
                        HStack {
                            ProgressView().frame(width: 16, height: 16)
                            Text(wordingManager.wordings.statusEstablishingConnection, font: themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.tertiaryBlack)
                        }
                    }
                }
                .padding()
            }

            VStack {
                if quality == .degraded {
                    // TODO: Add this string to POEditor!
                    Text(wordingManager.wordings.positioningTip, font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                }
            }
            .frame(height: 20)

            Spacer()
        }
    }

    private func sheetContent() -> some View {
        VStack {
            Text(wordingManager.wordings.cancelPopupTitle)
                .font(themeManager.selectedTheme.headline4)
            Text(wordingManager.wordings.cancelPopupMessage)
                .font(themeManager.selectedTheme.paragraph1)
                .padding()
            Button(wordingManager.wordings.cancelPopupBackToPositioningButton) {
                viewModel.send(.cancelViewDismissed)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .anyView
            Button(wordingManager.wordings.cancelPopupCancelButton) {
                viewModel.send(.confirmPositioningCancel)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
            .anyView
            
        }
        .padding(.bottom, 16)
    }
}
