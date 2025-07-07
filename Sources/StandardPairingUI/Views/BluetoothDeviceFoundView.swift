// Copyright (c) nami.ai

import CommonTypes
import NamiI18n
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
                if viewModel.state.deviceType == .unknown || viewModel.state.deviceType == deviceModel.deviceType {
                    if viewModel.state.deviceNameConfirmed && !viewModel.state.renameDevice {
                        AnyView(DevicePresentingLoadingView(deviceName: viewModel.state.deviceName, deviceModel: deviceModel)) 
                    } else {
                        AnyView(askToName(model: deviceModel))
                    }
                } else {
                    deviceDiscovered()
                }
            } else {
                deviceDiscovered()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            self.isKeyboardAppeared = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.isKeyboardAppeared = false
        }
        .onDisappear {
            self.isEditing = false
            self.isKeyboardAppeared = false
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel       
    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager

    // MARK: Private
    @State private var isKeyboardAppeared: Bool = false
    @State private var isEditing: Bool = true

    private func navigationBarTitle() -> String {
        if isSettingUpKit(wordings: wordingManager.wordings) {
            return kitName(wordings: wordingManager.wordings)
        }
        
        if let deviceModel = viewModel.state.deviceModel, deviceModel.deviceType != .unknown {
            return deviceModel.deviceType.localizedName
        }
        
        return I18n.pairingDeviceSetupNavigationTitle
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
            Text(wordingManager.wordings.nameYourDevice)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.top, 8)
                .padding(.horizontal)
                .padding(.bottom, 4)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(wordingManager.wordings.nameDeviceExplained)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            NamiTextField(placeholder: viewModel.state.deviceName, text: $viewModel.state.deviceName, isEditing: $isEditing, returnKeyType: .done, subTextFont: themeManager.selectedTheme.paragraph2)
                .subText(viewModel.state.showDuplicateError ? wordingManager.wordings.nameAlreadyInUseError : "")
                .style(viewModel.state.showDuplicateError ? .negative : .neutral)
                .padding(.horizontal)
                .padding(.top, 16)
                .frame(maxWidth: .infinity)
                .onAppear {
                    isEditing = true
                }
                .onDisappear {
                    isEditing = false 
                }
            Spacer()
            Button(wordingManager.wordings.nextButton) {
                isKeyboardAppeared = false
                viewModel.send(event: .deviceNameConfirmed)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .disabled(viewModel.state.deviceName.trimmingWhitespaces.isEmpty || viewModel.state.showDuplicateError)
            .padding(.bottom, isKeyboardAppeared ? NamiActionButtonStyle.ConstraintLayout.BottomTokeyboard : NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
            .anyView
        }
    }
}
