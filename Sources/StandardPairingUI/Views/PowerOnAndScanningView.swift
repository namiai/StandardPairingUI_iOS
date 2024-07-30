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
        DeviceSetupScreen(title: wordingManager.wordings.pairingNavigationBarTitle) {
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
            Spacer()
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
            
            LottieAnimationView(animation: \.contactSensorPulsingDarkBlue)
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
}
