// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
@_implementationOnly import NamiSharedUIElements
import SharedAssets

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle
    
    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Public
    
    public var body: some View {
        NamiTopNavigationScreen(
            title: navigationBarTitle(),
            colorOverride: themeManager.selectedTheme.navigationBarColor,
            contentBehavior: .fixed,
            mainContent: {
                self.scanningForDevice()
            })
        .environment(\.hideBackButton, true)
        .ignoresSafeArea(.keyboard)
    }
    
    private enum PairingLedColor {
        case blue
        case white
    }
    
    private var pairingLedColor: PairingLedColor {
        switch viewModel.state.deviceType {
        case .contactSensor,
                .motionSensor:
            return .white
        default:
            return .blue
        }
    }
    private var header: String {
        return switch viewModel.state.deviceType {
        case .contactSensor,
                .motionSensor:
            wordingManager.wordings.headerContactSensor
        case .keypad:
            wordingManager.wordings.headerKeypad
        default:
            wordingManager.wordings.headerConnectToPower
        }
    }
    private var explanation: String {
        return switch viewModel.state.deviceType {
        case .contactSensor,
                .motionSensor, 
                .keypad:
            I18n.pairingBluetoothDeviceFoundExplainedReadyToPairContactSensor
        default:
            wordingManager.wordings.explainedReadyToPair
        }
    }
    private var faqText: String {
        return switch pairingLedColor {
        case .blue: wordingManager.wordings.pairingScanningBleFaq
        case .white: wordingManager.wordings.pairingScanningBleFaqDoorSensor
        }
    }
    // MARK: Internal
    
    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    @Environment(\.colors) private var colors
    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    
    private func navigationBarTitle() -> String {
        if viewModel.state.setupType == .updateWiFiCreds {
            return I18n.updateWifiTitle
        }
        
        if isSettingUpKit(wordings: wordingManager.wordings) {
            return kitName(wordings: wordingManager.wordings)
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigationTitle
    }
    
    @ViewBuilder
    private func scanningForDevice() -> some View {
        VStack {
            Text(header)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(colors.textDefaultPrimary)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(explanation)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(colors.textDefaultPrimary)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            switch viewModel.state.centralState.bluetoothState {
            case .poweredOn:
                // Bluetooth is ON, check authorization for new connections
                switch viewModel.state.centralState.authorization {
                case .notDetermined, .allowedAlways:
                    darkPulseAnimation()
                        .padding(.horizontal)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                    
                    Text(wordingManager.wordings.scanning)
                        .font(themeManager.selectedTheme.headline3)
                        .foregroundColor(colors.textDefaultPrimary)
                        .padding(.horizontal)
                    Text(wordingManager.wordings.askUserToWait)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(colors.textDefaultPrimary)
                        .padding(.horizontal)
                        .padding(.top, 4)
                    if viewModel.state.showsProgressIndicator {
                        ProgressView()
                            .padding()
                    }
                case .denied:
                    Spacer()
                    bluetoothNotAvailable()
                case .restricted:
                    Spacer()
                    bluetoothRestricted()
                @unknown default:
                    EmptyView()
                }
            case .poweredOff:
                Spacer()
                bluetoothIsOff()
            case .unauthorized:
                Spacer()
                bluetoothRestricted()
            default:
                EmptyView()
            }
            
            Spacer()
            
            NamiTextHyperLinkHelpers.hyperLink(
                text: faqText,
                link: wordingManager.wordings.urlNotPulsingBlue,
                linkColor: colors.textDefaultPrimary
            )
            .font(themeManager.selectedTheme.paragraph1)
            .foregroundColor(colors.textDefaultPrimary)
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
    }
    
    @ViewBuilder
    private func darkPulseAnimation() -> some View {
        VStack {
            switch viewModel.state.deviceType {
            case .contactSensor:
                LottieAnimationView(animation: \.doorSensorPulseWhite)
            case .keypad:
                LottieAnimationView(animation: \.keypadPulseWhite)
            case .motionSensor:
                LottieAnimationView(animation: \.motionSensorPulseWhite)
            case .meshSensor:
                switch viewModel.state.outletType {
                case .typeE:
                    LottieAnimationView(animation: \.sensePlugFRPulseDarkBlue)
                case .typeF:
                    LottieAnimationView(animation: \.sensePlugDEPulseDarkBlue)
                case .typeG:
                    LottieAnimationView(animation: \.sensePlugUKPulseDarkBlue)
                case .typeB:
                    LottieAnimationView(animation: \.sensePlugUSPulseDarkBlue)
                case .typeA:
                    LottieAnimationView(animation: \.sensePlugJPPulseDarkBlue)
                case .unknown, .none:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            case .securityPod:
                LottieAnimationView(animation: \.alarmPodPulseDarkBlue)
            case .alarmPod:
                LottieAnimationView(animation: \.alarmPodPulseDarkBlue)
            case .sensePod:
                LottieAnimationView(animation: \.sensePodPulseDarkBlue)
            case .wifiSensor:
                switch viewModel.state.outletType  {
                case .typeE:
                    LottieAnimationView(animation: \.wifiSensorFRPulseDarkBlue)
                case .typeF:
                    LottieAnimationView(animation: \.wifiSensorDEPulseDarkBlue)
                case .typeG:
                    LottieAnimationView(animation: \.wifiSensorUKPulseDarkBlue)
                case .typeB:
                    LottieAnimationView(animation: \.wifiSensorUSPulseDarkBlue)
                case .typeA:
                    LottieAnimationView(animation: \.wifiSensorJPPulseDarkBlue)
                case .unknown, .none:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            case .widarSensor:
                LottieAnimationView(animation: \.widarPulseDarkBlue)
            case .unknown:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    
    @ViewBuilder
    private func bluetoothNotAvailable() -> some View {
        VStack(alignment: .center) {
            Icons.bluetooth
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(wordingManager.wordings.bluetoothDisabled)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(colors.textDefaultPrimary)
            Text(wordingManager.wordings.enableBlueToothInSettingsHeader)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(colors.textDefaultPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button(wordingManager.wordings.buttonSettings, action: openSettings)
                .buttonStyle(.borderless)
                .padding()
        }
    }
    
    @ViewBuilder
    private func bluetoothIsOff() -> some View {
        VStack(alignment: .center) {
            Icons.bluetooth
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(wordingManager.wordings.bluetoothIsOff)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(colors.textDefaultPrimary)
            Text(wordingManager.wordings.bluetoothIsOffDescription)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(colors.textDefaultPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button(wordingManager.wordings.buttonSettings, action: openBluetoothSettings)
                .buttonStyle(.borderless)
                .padding()
        }
    }
    
    @ViewBuilder
    private func bluetoothRestricted() -> some View {
        VStack(alignment: .center) {
            Icons.bluetooth
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(wordingManager.wordings.bluetoothRestricted)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(colors.textDefaultPrimary)
            Text(wordingManager.wordings.bluetoothRestrictedDescription)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(colors.textDefaultPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button(wordingManager.wordings.buttonSettings, action: openSettings)
                .buttonStyle(.borderless)
                .padding()
        }
    }
    
    private func openSettings() {
        guard
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings)
        else {
            return
        }
        
        UIApplication.shared.open(settings, completionHandler: nil)
    }
    
    private func openBluetoothSettings() {
        if let url = URL(string: "App-Prefs:root=Bluetooth"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
    }
}
