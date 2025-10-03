// Copyright (c) nami.ai

import CommonTypes
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

public struct PositioningGuidanceView: View {
    // MARK: Lifecycle

    public init(viewModel: PositioningGuidance.ViewModel) {
        self.viewModel = viewModel
        _onDismissErrorAction = State(initialValue: nil)
    }

    // MARK: Public

    public var body: some View {
        let cancelSheetBinding = Binding {
            viewModel.state.wantCancel
        } set: { wantCancel in
            if wantCancel == false {
                viewModel.send(.cancelViewDismissed)
            }
        }

        NamiTopNavigationScreen(
            title: wordingManager.wordings.positioningNavigationTitle,
            colorOverride: themeManager.selectedTheme.navigationBarColor
        ) {
            mainContent()
                .padding()
                .navigationPopGestureDisabled(true)
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
        .dynamicBottomSheet(isPresented: cancelSheetBinding, dragIndicatorVisible: false, onDismiss: $onDismissErrorAction, content: { sheetContent() })
        .namiAllowSwipeBackNavigation(false)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations
    @Environment(\.colors) var colors: Colors
    @Environment(\.measurementSystem) var measurementSystem: MeasurementSystem
    @ObservedObject var viewModel: PositioningGuidance.ViewModel

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager

    @State private var onDismissErrorAction: (() -> Void)? = {}

    private func mainContent() -> some View {
        VStack {
            Text(wordingManager.wordings.positioningGuidanceTitle)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(colors.textDefaultPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom])

            switch measurementSystem {
            case .metric:
                Text(wordingManager.wordings.guideMetric, font: themeManager.selectedTheme.paragraph1).namiFillWidth()
            case .uk:
                Text(wordingManager.wordings.guideImperial, font: themeManager.selectedTheme.paragraph1).namiFillWidth()
            case .us:
                Text(wordingManager.wordings.guideImperial, font: themeManager.selectedTheme.paragraph1).namiFillWidth()
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
                    Text(wordingManager.wordings.statusLabel, font: themeManager.selectedTheme.paragraph1).namiFillWidth(alignment: .center)
                    if viewModel.state.positioningState == .started {
                        HStack {
                            switch quality {
                            case .unknown:
                                ProgressView().frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusChecking, font: themeManager.selectedTheme.headline5).foregroundColor(colors.textDefaultTertiary)
                            case .poor:
                                Circle().fill(colors.iconDangerPrimary).frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusMispositioned, font: themeManager.selectedTheme.headline5).foregroundColor(colors.textDangerPrimary)
                            case .degraded:
                                Circle().fill(colors.iconSecuritymodeOrange).frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusGettingBetter, font: themeManager.selectedTheme.headline5).foregroundColor(colors.textSecuritymodeOrange)
                            case .good:
                                Circle().fill(colors.iconSecuritymodeGreen).frame(width: 16, height: 16)
                                Text(wordingManager.wordings.statusOptimized, font: themeManager.selectedTheme.headline5).foregroundColor(colors.textSecuritymodeGreen)
                            }
                        }
                    } else {
                        HStack {
                            ProgressView().frame(width: 16, height: 16)
                            Text(wordingManager.wordings.statusEstablishingConnection, font: themeManager.selectedTheme.headline5).foregroundColor(colors.textDefaultTertiary)
                        }
                    }
                }
                .padding()
            }

            VStack {
                if quality == .degraded {
                    // TODO: Add this string to POEditor!
                    Text(wordingManager.wordings.positioningTip, font: themeManager.selectedTheme.paragraph1)
                        .foregroundColor(colors.textDefaultPrimary)
                        .namiFillWidth(alignment: .center)
                }
            }
            .frame(height: 20)

            Spacer()
        }
    }

    @ViewBuilder
    private func sheetContent() -> some View {
        VStack {
            Text(wordingManager.wordings.cancelPopupTitle)
                .font(themeManager.selectedTheme.headline4)
            Text(wordingManager.wordings.cancelPopupMessage)
                .font(themeManager.selectedTheme.paragraph1)
                .padding(.top, 16)
                .padding(.bottom, 32)
            Button(wordingManager.wordings.cancelPopupBackToPositioningButton) {
                viewModel.send(.cancelViewDismissed)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.bottom, NamiActionButtonStyle.ConstraintLayout.BottomToNextButton)
            .anyView
            Button(wordingManager.wordings.cancelPopupCancelButton) {
                viewModel.send(.confirmPositioningCancel)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
            .padding(.bottom, NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
            .anyView
        }
        .frame(maxHeight: 300)
        .ignoresSafeArea()
        .anyView
    }
}
