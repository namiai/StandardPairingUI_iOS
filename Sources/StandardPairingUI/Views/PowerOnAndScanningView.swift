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
        DeviceSetupScreen(title: viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : wordingManager.wordings.pairingNavigationBarTitle) {
            switch viewModel.state.deviceType {
            case .contactSensor:
                self.ContactSensorDeviceTypeScanning()
            default:
                self.GeneralDeviceTypeScanning()
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    // MARK: Internal

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
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
            Spacer()
            
            if #available(iOS 15, *) {
                NamiTextHyperLink(text: wordingManager.wordings.pairingScanningBleFaq, link: wordingManager.wordings.urlNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            } else {
                NamiTextHyperLinkLegacy(text: wordingManager.wordings.pairingScanningBleFaq, link: wordingManager.wordings.urlNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
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
            
            Text(wordingManager.wordings.explainedReadyToPair)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
            Spacer()
            if #available(iOS 15, *) {
                NamiTextHyperLink(text: wordingManager.wordings.pairingScanningBleFaqDoorSensor, link: wordingManager.wordings.urlNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            } else {
                NamiTextHyperLinkLegacy(text: wordingManager.wordings.pairingScanningBleFaqDoorSensor, link: wordingManager.wordings.urlNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
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
}
