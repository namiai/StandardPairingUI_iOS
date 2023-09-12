// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

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
            if let codeName = viewModel.state.deviceModel?.codeName {
                DeviceImages.image(for: codeName)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            if let modelTitle = viewModel.state.deviceModel?.productLabel {
                Text(I18n.Pairing.BluetoothDeviceFound.header1Known.localized(with: modelTitle))
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
            } else {
                Text(I18n.Pairing.BluetoothDeviceFound.header1.localized)
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
            }
            
            if viewModel.state.deviceModel != nil {
                Text("How woud you like to name the device?")
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity)
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
            } else {
                Text(I18n.Pairing.BluetoothDeviceFound.header2.localized)
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity)
                ProgressView()
                Spacer()
            }
        }
    }
}
