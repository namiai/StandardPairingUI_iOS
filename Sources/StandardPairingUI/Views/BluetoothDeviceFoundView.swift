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
            Text("\(model.productLabel.capitalized) found!")
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Name tour \(model.productLabel) to identify it easier among other devices")
                .font(NamiTextStyle.paragraph1.font)
                .frame(maxWidth: .infinity, alignment: .leading)
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
            .disabled(deviceName.isEmpty)
            .padding([.bottom, .horizontal])
        }
    }
}
