// Copyright (c) nami.ai

import CommonTypes
import I18n
import SwiftUI
import Tomonari

// MARK: - BluetoothDeviceFoundView

public struct BluetoothDeviceFoundView: View {
    // MARK: Lifecycle

    public init(viewModel: BluetoothDeviceFound.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

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
        .onAppear {
            deviceName = viewModel.state.deviceName
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel
    @State var deviceName: String = ""

    // MARK: Private

    private func deviceDiscovered() -> some View {
        VStack {
            Spacer()

            Text(I18n.Pairing.BluetoothDeviceFound.header1)
                .font(NamiTextStyle.headline3.font)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity)

            Text(I18n.Pairing.BluetoothDeviceFound.header2)
                .font(NamiTextStyle.paragraph1.font)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            ProgressView()

            Spacer()
        }
    }

    private func askToName(model: NamiDeviceModel) -> some View {
        VStack {
            Text(I18n.Pairing.BluetoothDeviceFound.nameDeviceHeader( model.productLabel.capitalized))
                .font(NamiTextStyle.headline3.font)
                .padding([.horizontal, .top])
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(I18n.Pairing.BluetoothDeviceFound.nameDeviceExplained( model.productLabel))
                .font(NamiTextStyle.paragraph1.font)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            NamiTextField(placeholder: viewModel.state.deviceName, text: $deviceName)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            Spacer()
            Button(I18n.Pairing.BluetoothDeviceFound.nextButton) {
                viewModel.send(event: .deviceNameConfirmed(deviceName))
            }
            .buttonStyle(NamiActionButtonStyle())
            .disabled(deviceName.isEmpty)
            .padding([.bottom, .horizontal])
        }
    }
}
