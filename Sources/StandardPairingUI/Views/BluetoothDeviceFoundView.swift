// Copyright (c) nami.ai

import CommonTypes
import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements

// MARK: - BluetoothDeviceFoundView

public struct BluetoothDeviceFoundView: View {
    // MARK: Lifecycle

    public init(viewModel: BluetoothDeviceFound.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: navigationBarTitle()) {
            if let deviceModel = viewModel.state.deviceModel {
                viewModel.state.deviceNameConfirmed ?
                    AnyView(DevicePresentingLoadingView(deviceName: viewModel.state.deviceName, deviceModel: deviceModel)) :
                    AnyView(askToName(model: deviceModel))
            } else {
                deviceDiscovered()
            }
        }
//        .onAppear {
//            deviceName = viewModel.state.deviceName
//        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            self.isKeyboardAppeared = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.isKeyboardAppeared = false
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel
//    @State var deviceName = ""
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private
    @SwiftUI.State private var isKeyboardAppeared: Bool = false

    private func navigationBarTitle() -> String {
        if let deviceModel = viewModel.state.deviceModel, deviceModel.deviceType != .unknown {
            return deviceModel.deviceType.localizedName
        }
        
        return wordingManager.wordings.pairingNavigationBarTitle
    }
    
    private func deviceDiscovered() -> some View {
        VStack {
            Spacer()

            Text(wordingManager.wordings.deviceFoundHeader1)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity)

            Text(wordingManager.wordings.deviceFoundHeader2)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            ProgressView()

            Spacer()
        }
    }

    private func askToName(model: NamiDeviceModel) -> some View {
        VStack {
            Text(wordingManager.wordings.askToNameHeader(productLabel: model.productLabel))
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(wordingManager.wordings.nameDeviceExplained)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            NamiTextField(placeholder: viewModel.state.deviceName, text: $viewModel.state.deviceName, textFieldFont: themeManager.selectedTheme.paragraph1, subTextFont: themeManager.selectedTheme.small1)
                .subText(viewModel.state.showDuplicateError ? "This device name is already in use. Please use a different name." : "")
                .style(viewModel.state.showDuplicateError ? .negative : .neutral)
                .padding(.horizontal)
                .padding(.top, 32)
                .frame(maxWidth: .infinity)
            Spacer()
            Button(wordingManager.wordings.nextButton) {
                viewModel.send(event: .deviceNameConfirmed)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .disabled(viewModel.state.deviceName.trimmingWhitespaces.isEmpty || viewModel.state.showDuplicateError)
            .padding(.bottom, isKeyboardAppeared ? NamiActionButtonStyle.ConstraintLayout.BottomTokeyboard : NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
            .padding(.horizontal)
            .anyView
        }
    }
}
