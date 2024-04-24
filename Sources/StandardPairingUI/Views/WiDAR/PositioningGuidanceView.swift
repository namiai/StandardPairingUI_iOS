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

    @ObservedObject var viewModel: PositioningGuidance.ViewModel

    public var body: some View {
        let cancelSheetBinding = Binding {
            viewModel.state.wantCancel
        } set: { wantCancel in
            if wantCancel == false {
                viewModel.send(.cancelViewDismissed)
            }
        }

        NamiTopNavigationScreen(title: I18n.Widar.headerTitle, largeTitle: I18n.Widar.Position.title, contentBehavior: .fixed) {
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
                .buttonStyle(NamiActionButtonStyle())
                .disabled(viewModel.state.canNotFinish)

                Button(I18n.Widar.Position.cancelButton) {
                    viewModel.send(.wantCancelTapped)
                }
                .buttonStyle(NamiActionButtonStyle(rank: .tertiary))
                .disabled(viewModel.state.canNotCancel)
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
            switch measurementSystem {
            case .metric:
                Text(I18n.Widar.Position.guideMetric, font: .paragraph1).fillWidth()
            case .uk:
                Text(I18n.Widar.Position.guideImperial, font: .paragraph1).fillWidth()
            case .us:
                Text(I18n.Widar.Position.guideImperial, font: .paragraph1).fillWidth()
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
                    Text(I18n.Widar.Position.statusLabel, font: .paragraph1).fillWidth(alignment: .center)
                    if viewModel.state.positioningState == .started {
                        HStack {
                            switch quality {
                            case .unknown:
                                ProgressView().frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusChecking, font: .headline5).foregroundColor(colors.neutral.tertiaryBlack)
                            case .poor:
                                Circle().fill(Color.red).frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusMispositioned, font: .headline5).foregroundColor(colors.redAlert4)
                            case .degraded:
                                Circle().fill(Color.yellow).frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusGettingBetter, font: .headline5).foregroundColor(colors.lowAttentionAlert)
                            case .good:
                                Circle().fill(Color.green).frame(width: 16, height: 16)
                                Text(I18n.Widar.Position.statusOptimized, font: .headline5).foregroundColor(colors.success4)
                            }
                        }
                    } else {
                        HStack {
                            ProgressView().frame(width: 16, height: 16)
                            Text("Establishing connection", font: .headline5).foregroundColor(colors.neutral.tertiaryBlack)
                        }
                    }
                }
                .padding()
            }

            VStack {
                if quality == .degraded {
                    // TODO: Add this string to POEditor!
                    Text(I18n.Widar.Position.tip, font: .paragraph1).fillWidth(alignment: .center)
                }
            }
            .frame(height: 20)

            Spacer()
        }
    }

    private func sheetContent() -> some View {
        VStack {
            Text(I18n.Widar.CancelPopup.title)
                .font(NamiTextStyle.headline4.font)
            Text(I18n.Widar.CancelPopup.message)
                .font(NamiTextStyle.paragraph1.font)
                .padding()
            Button(I18n.Widar.CancelPopup.backToPositioningButton) {
                viewModel.send(.cancelViewDismissed)
            }
            .buttonStyle(NamiActionButtonStyle())
            Button(I18n.Widar.CancelPopup.cancelButton) {
                viewModel.send(.confirmPositioningCancel)
            }
            .buttonStyle(NamiActionButtonStyle(rank: .secondary))
            
        }
        .padding(.bottom, 16)
    }
}
