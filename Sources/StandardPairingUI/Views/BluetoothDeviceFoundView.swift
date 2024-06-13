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
        DeviceSetupScreen(title: titleWording()) {
            if let deviceModel = viewModel.state.deviceModel {
                viewModel.state.deviceNameConfirmed ?
                    AnyView(DevicePresentingLoadingView(deviceName: deviceName, deviceModel: deviceModel)) :
                    AnyView(askToName(model: deviceModel))
            } else {
                deviceDiscovered()
            }
        }
        .onAppear {
            deviceName = viewModel.state.deviceName
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel
    @State var deviceName = ""
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private

    private func deviceDiscovered() -> some View {
        VStack {
            Spacer()

            Text(deviceFoundHeader1())
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity)

            Text(deviceFoundHeader2())
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
            Text(askToNameHeaderText(model: model))
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(nameDeviceExplained())
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            NamiTextField(placeholder: viewModel.state.deviceName, text: $deviceName, textFieldFont: themeManager.selectedTheme.paragraph1, subTextFont: themeManager.selectedTheme.small1)
                .padding(.horizontal)
                .padding(.top, 32)
                .frame(maxWidth: .infinity)
            Spacer()
            Button(nextButton()) {
                viewModel.send(event: .deviceNameConfirmed(deviceName))
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .disabled(deviceName.isEmpty)
            .padding([.bottom, .horizontal])
            .anyView
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.Pairing.DeviceSetup.navigagtionTitle
    }
    
    private func deviceFoundHeader1() -> String {
        if let customString = wordingManager.wordings.deviceFoundHeader1 {
            return customString
        }
        
        return I18n.Pairing.BluetoothDeviceFound.header1
    }
    
    private func deviceFoundHeader2() -> String {
        if let customString = wordingManager.wordings.deviceFoundHeader2 {
            return customString
        }
        
        return I18n.Pairing.BluetoothDeviceFound.header2
    }
    
    private func askToNameHeaderText(model: NamiDeviceModel) -> String {
        if let customString = wordingManager.wordings.askToNameHeader {
            return customString
        }
        
        return I18n.Pairing.BluetoothDeviceFound.nameDeviceHeader(model.productLabel.capitalized)
    }
    
    private func nameDeviceExplained() -> String {
        if let customString = wordingManager.wordings.nameDeviceExplained {
            return customString
        }
        
        return I18n.Pairing.BluetoothDeviceFound.nameDeviceExplained
    }
    
    private func nextButton() -> String {
        if let customString = wordingManager.wordings.nextButton {
            return customString
        }
        
        return I18n.Pairing.BluetoothDeviceFound.nextButton
    }
}
