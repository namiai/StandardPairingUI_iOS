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

    @ObservedObject var viewModel: PositioningGuidance.ViewModel

    public var body: some View {
        let cancelSheetBinding = Binding {
            viewModel.state.wantCancel
        } set: { wantCancel in
            if wantCancel == false {
                viewModel.send(.cancelViewDismissed)
            }
        }

        DeviceSetupScreen(title: I18n.Widar.headerTitle) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            VStack {
                Button(I18n.Widar.Position.finishButton) {
                    viewModel.send(.wantFinishTapped)
                }
                .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                .disabled(viewModel.state.canNotFinish)
                .anyView

                Button(I18n.Widar.Position.cancelButton) {
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
            Text(I18n.Widar.Position.title)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom])
            
            switch measurementSystem {
            case .metric:
                Text(I18n.Widar.Position.guideMetric, font: themeManager.selectedTheme.paragraph1).fillWidth()
            case .uk:
                Text(I18n.Widar.Position.guideImperial, font: themeManager.selectedTheme.paragraph1).fillWidth()
            case .us:
                Text(I18n.Widar.Position.guideImperial, font: themeManager.selectedTheme.paragraph1).fillWidth()
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
                    Text(I18n.Widar.Position.statusLabel, font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                    if viewModel.state.positioningState == .started {
                        HStack {
                            switch quality {
                            case .unknown:
                                ProgressView().frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusChecking, font: themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.tertiaryBlack)
                            case .poor:
                                Circle().fill(Color.red).frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusMispositioned, font: themeManager.selectedTheme.headline5).foregroundColor(colors.redAlert4)
                            case .degraded:
                                Circle().fill(Color.yellow).frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusGettingBetter, font: themeManager.selectedTheme.headline5).foregroundColor(colors.lowAttentionAlert)
                            case .good:
                                Circle().fill(Color.green).frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusOptimized, font: themeManager.selectedTheme.headline5).foregroundColor(colors.success4)
                            }
                        }
                    } else {
                        HStack {
                            ProgressView().frame(width: 16, height: 16)
                            Text("Establishing connection", font: themeManager.selectedTheme.headline5).foregroundColor(colors.neutral.tertiaryBlack)
                        }
                    }
                }
                .padding()
            }

            VStack {
                if quality == .degraded {
                    // TODO: Add this string to POEditor!
                    Text(I18n.Widar.Position.tip, font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                }
            }
            .frame(height: 20)

            Spacer()
        }
    }

    private func sheetContent() -> some View {
        VStack {
            Text(I18n.Widar.CancelPopup.title)
                .font(themeManager.selectedTheme.headline4)
            Text(I18n.Widar.CancelPopup.message)
                .font(themeManager.selectedTheme.paragraph1)
                .padding()
            Button(I18n.Widar.CancelPopup.backToPositioningButton) {
                viewModel.send(.cancelViewDismissed)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .anyView
            Button(I18n.Widar.CancelPopup.cancelButton) {
                viewModel.send(.confirmPositioningCancel)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
            .anyView
            
        }
        .padding(.bottom, 16)
    }
}
