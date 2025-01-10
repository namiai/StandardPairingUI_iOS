// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements
import SharedAssets

// MARK: - PairingErrorScreenView

public struct PairingErrorScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: PairingErrorScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public
    
    @Environment(\.colors) var colors: Colors

    public var body: some View {
        DeviceSetupScreen(title: navigationBarTitle()) {
            Spacer()
            VStack(alignment: .center) {
                Image("Warning", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                // TODO: Switch to use `viewModel.state.error.errorMessageTitle` when there's the values for it in I18n but not hardcoded strings.
                // The preparation is done in `PairingErrorsExtensions`.
                Text(viewModel.state.error.getErrorMessageTitle(wordings: wordingManager.wordings))
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .fixedSize(horizontal: false, vertical: true)
                if viewModel.state.deviceType == .contactSensor {
                    Text(viewModel.state.error.getErrorMessageDescription(wordings: wordingManager.wordings))
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 4)
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(wordingManager.wordings.pairingThreadErrorContactSensorNoThreadNetworksFoundDescription2)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 2)
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    switch viewModel.state.error {
                    case .underlying(PairingMachineError.unexpectedState): 
                        EmptyView()
                    case let .underlying(PairingMachineError.bluetoothDisconnectedError(_, canRetry)):
                        if canRetry {
                            Text(viewModel.state.error.getErrorMessageDescription(wordings: wordingManager.wordings))
                                .font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.top, 2)
                                .lineLimit(4)
                                .fixedSize(horizontal: false, vertical: true)
                        } else {
                            EmptyView()
                        }
                    default: 
                        Text(viewModel.state.error.getErrorMessageDescription(wordings: wordingManager.wordings))
                            .font(themeManager.selectedTheme.paragraph1)
                            .foregroundColor(themeManager.selectedTheme.primaryBlack)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 2)
                            .lineLimit(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                if let urlLink = viewModel.state.error.getFAQLink(wordings: wordingManager.wordings) {
                    if #available(iOS 15, *) {
                        NamiTextHyperLink(text: wordingManager.wordings.pairingErrorNeedHelp, link: urlLink, linkColor: colors.neutral.secondaryBlack)
                            .font(NamiTextStyle.paragraph1.font)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)
                    } else {
                        NamiTextHyperLinkLegacy(text: wordingManager.wordings.pairingErrorNeedHelp, link: urlLink, linkColor: colors.neutral.secondaryBlack)
                            .font(NamiTextStyle.paragraph1.font)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
            VStack {
                if viewModel.state.actions.isEmpty == false {
                    ForEach(0..<viewModel.state.actions.count, id: \.self, content: buttonForAction)
                }
            }
        }
        .allowSwipeBackNavigation(false)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: PairingErrorScreen.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private

    private func navigationBarTitle() -> String {
        if !wordingManager.wordings.pairingNavigationBarTitle.isEmpty { 
            return wordingManager.wordings.pairingNavigationBarTitle
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigationTitle
    }
    
    private func buttonForAction(at index: Int) -> some View {
        let actions = viewModel.state.actions
        let action = actions[index]

        if case let .underlying(error) = viewModel.state.error {
            if let error = error as? PairingMachineError, case .notSupportDeviceType(_) = error {
                // Hacky way of handling if this is a kit system is currently being set up
                // Skip rendering if the action is `.restart` and `pairingNavigationBarTitle` is not empty
                if action == .restart && !wordingManager.wordings.pairingNavigationBarTitle.isEmpty {
                    return EmptyView().anyView
                }
                
                if action == .tryAgain && wordingManager.wordings.pairingNavigationBarTitle.isEmpty {
                    return EmptyView().anyView
                }
            }
        }
        
        let style = index == 0 ? themeManager.selectedTheme.primaryActionButtonStyle : themeManager.selectedTheme.secondaryActionButtonStyle
        
        return Button(titleForAction(action), action: { viewModel.send(event: .didChooseAction(action)) })
            .disabled(viewModel.state.chosenAction != nil)
            .buttonStyle(style)
            .padding(.bottom, index == actions.count-1 ? NamiActionButtonStyle.ConstraintLayout.BottomToSuperView : NamiActionButtonStyle.ConstraintLayout.BottomToNextButton)
            .anyView
    }

    private func titleForAction(_ action: Pairing.ActionOnError) -> String {
        switch action {
        case .tryAgain:
            if case let .underlying(error) = viewModel.state.error {
                if let error = error as? PairingMachineError, case .notSupportDeviceType(_) = error {
                    return wordingManager.wordings.scanDeviceAgainActionTitle
                }
            } 
            
            return wordingManager.wordings.tryAgainActionTitle
        case .restart:            
            return wordingManager.wordings.restartSetupActionTitle
        case .ignore:
            return wordingManager.wordings.ignoreActionTitle
        case .exit:
            return wordingManager.wordings.exitSetupActionTitle

        }
    }
}
