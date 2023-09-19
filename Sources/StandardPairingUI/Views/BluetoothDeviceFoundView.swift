// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n
import CommonTypes

// MARK: - BluetoothDeviceFoundView

public struct BluetoothDeviceFoundView: View {
    // MARK: Lifecycle
    
    public init(viewModel: BluetoothDeviceFound.ViewModel) {
        self.viewModel = viewModel
        self.deviceName = viewModel.state.deviceName
    }
    
    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel
    @State var deviceName: String
    
    public var body: some View {
        DeviceSetupScreen {
            Spacer()
            
            if let deviceModel = viewModel.state.deviceModel {
                viewModel.state.deviceNameConfirmed ?
                AnyView(DevicePresentingLoadingView(deviceName: deviceName, deviceModel: deviceModel)) :
                AnyView(askToName(model: deviceModel))
            } else {
                deviceDiscovered()
            }
        }
    }
    
    private func deviceDiscovered() -> some View {
        VStack {
            Spacer()
            
            Text(I18n.Pairing.BluetoothDeviceFound.header1.localized)
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            
            Text(I18n.Pairing.BluetoothDeviceFound.header2.localized)
                .font(NamiTextStyle.paragraph1.font)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 4)
            ProgressView()
            
            Spacer()
        }
    }
    
    private func askToName(model: NamiDeviceModel) -> some View {
        VStack {
            Text(I18n.Pairing.BluetoothDeviceFound.header1Known.localized(with: model.productLabel))
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            
            Text("How woud you like to name the device?")
                .font(NamiTextStyle.paragraph1.font)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 4)
            NamiTextField(placeholder: viewModel.state.deviceName, text: $deviceName)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            Spacer()
            Button("Next") {
                viewModel.send(event: .deviceNameConfirmed(deviceName))
            }
            .buttonStyle(NamiActionButtonStyle())
            .disabled(viewModel.state.deviceName.isEmpty)
            .padding([.bottom, .horizontal])
        }
    }
}
