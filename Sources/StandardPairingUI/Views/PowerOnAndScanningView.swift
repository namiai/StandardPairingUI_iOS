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
        DeviceSetupScreen(
            title: navigationBarTitle()
        ) {
            switch viewModel.state.deviceType {
            case .contactSensor:
                self.ContactSensorDeviceTypeScanning()
            default:
                self.GeneralDeviceTypeScanning()
            }
        }
        .environment(\.hideBackButton, true)
        .ignoresSafeArea(.keyboard)
    }
    
    // MARK: Internal

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
    private func navigationBarTitle() -> String {
        if !wordingManager.wordings.pairingNavigationBarTitle.isEmpty { 
            return wordingManager.wordings.pairingNavigationBarTitle
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigationTitle
    }
    
    @ViewBuilder
    private func GeneralDeviceTypeScanning() -> some View {
        VStack {
            Text(wordingManager.wordings.headerConnectToPower)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(wordingManager.wordings.explainedReadyToPair)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .padding(.horizontal)
                    Text(wordingManager.wordings.askUserToWait)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
            
            NamiTextHyperLinkHelpers.hyperLink(text: wordingManager.wordings.pairingScanningBleFaq, link: wordingManager.wordings.urlNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
                .padding(.bottom, 16)
        }
    }
    
    @ViewBuilder
    private func ContactSensorDeviceTypeScanning() -> some View {
        VStack {
            Text(wordingManager.wordings.headerContactSensor)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // We don't need to have this in wordingManager yet
            Text(I18n.pairingBluetoothDeviceFoundExplainedReadyToPairContactSensor)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .padding(.horizontal)
                    
                    Text(wordingManager.wordings.askUserToWait)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .padding(.horizontal)
                    
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
            
            NamiTextHyperLinkHelpers.hyperLink(text: wordingManager.wordings.pairingScanningBleFaqDoorSensor, link: wordingManager.wordings.urlNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
            case .meshSensor:
                if let outletType = viewModel.state.outletType {
                    switch outletType {
                    case .typeE:
                        LottieAnimationView(animation: \.sensePlugFRPulseDarkBlue)
                    case .typeF:
                        LottieAnimationView(animation: \.sensePlugDEPulseDarkBlue)
                    case .typeG:
                        LottieAnimationView(animation: \.sensePlugUKPulseDarkBlue)
                    case .typeB:
                        LottieAnimationView(animation: \.sensePlugUSPulseDarkBlue)
                    case .typeA: 
                        LottieAnimationView(animation: \.sensePlugUSPulseDarkBlue)
                    case .unknown: 
                        EmptyView()    
                    }
                } else {
                    EmptyView()
                }
            case .securityPod:
                LottieAnimationView(animation: \.alarmPodPulseDarkBlue)
            case .alarmPod:
                LottieAnimationView(animation: \.alarmPodPulseDarkBlue)
            case .wifiSensor:
                if let outletType = viewModel.state.outletType {
                    switch outletType {
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
                    case .unknown: 
                        EmptyView()   
                    }
                } else {
                    EmptyView()
                }
            case .unknown:
                EmptyView()
            case .widarSensor:
                LottieAnimationView(animation: \.widarPulseDarkBlue)
                
            }
        }
    }
    
    
    @ViewBuilder
    private func bluetoothNotAvailable() -> some View {
        VStack(alignment: .center) {
            Image("Bluetooth", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(wordingManager.wordings.bluetoothDisabled)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
            Text(wordingManager.wordings.enableBlueToothInSettingsHeader)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
            Image("Bluetooth", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(wordingManager.wordings.bluetoothIsOff)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
            Text(wordingManager.wordings.bluetoothIsOffDescription)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
            Image("Bluetooth", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(wordingManager.wordings.bluetoothRestricted)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
            Text(wordingManager.wordings.bluetoothRestrictedDescription)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
