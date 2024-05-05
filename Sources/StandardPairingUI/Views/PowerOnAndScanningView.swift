// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements
import SharedAssets

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle

    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            // support multiple devicetypes
            if viewModel.state.deviceTypes.count > 1 {
                self.GeneralDeviceTypeScanning()
            } else {
                switch viewModel.state.deviceTypes.first {
                case .contactSensor:
                    self.ContactSensorDeviceTypeScanning()
                default:
                    self.GeneralDeviceTypeScanning()
                }
            }
        }
    }
    
    // MARK: Internal

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    
    @Environment(\.colors) var colors: Colors
    
    @ViewBuilder
    private func GeneralDeviceTypeScanning() -> some View {
        VStack {
            Text(I18n.Pairing.BluetoothDeviceFound.headerConnectToPower)
                .font(NamiTextStyle.headline3.font)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                .font(NamiTextStyle.paragraph1.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(I18n.Pairing.PowerOnAndScanning.scanning)
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
            Text(I18n.Pairing.PowerOnAndScanning.askUserToWait)
                .font(NamiTextStyle.paragraph1.font)
                .padding(.horizontal)
                .padding(.top, 4)
            if viewModel.state.showsProgressIndicator {
                ProgressView()
                    .padding()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func ContactSensorDeviceTypeScanning() -> some View {
        VStack {
            Text(I18n.Pairing.BluetoothDeviceFound.headerContactSensor)
                .font(NamiTextStyle.headline3.font)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                .font(NamiTextStyle.paragraph1.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LottieAnimationView(animation: \.contactSensorPulsingDarkBlue)
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            Text(I18n.Pairing.PowerOnAndScanning.scanning)
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
            
            Text(I18n.Pairing.PowerOnAndScanning.askUserToWait)
                .font(NamiTextStyle.paragraph1.font)
                .padding(.horizontal)
            
            if viewModel.state.showsProgressIndicator {
                ProgressView()
                    .padding()
            }
            Spacer()
            if #available(iOS 15, *) {
                NamiTextHyperLink(text: I18n.Pairing.BluetoothDeviceFound.FAQContactSensor, link: URLLinks.FAQNotPulsingBlue, linkColor: colors.neutral.primaryBlack)
                    .font(NamiTextStyle.paragraph1.font)
                    .foregroundColor(colors.neutral.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            } else {
                NamiTextHyperLinkLegacy(text: I18n.Pairing.BluetoothDeviceFound.FAQContactSensor, link: URLLinks.FAQNotPulsingBlue, linkColor: colors.neutral.primaryBlack)
                    .font(NamiTextStyle.paragraph1.font)
                    .foregroundColor(colors.neutral.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
        }
    }
}
