// Copyright (c) nami.ai

import CommonTypes
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

typealias NamiTextStyle = NamiSharedUIElements.NamiTextStyle
typealias RoundedRectContainerView = NamiSharedUIElements.RoundedRectContainerView
typealias NamiAuthButtonStyle = NamiSharedUIElements.NamiAuthButtonStyle
typealias NamiActionButtonStyle = NamiSharedUIElements.NamiActionButtonStyle
typealias NamiTextField = NamiSharedUIElements.NamiTextField
typealias DeviceImages = SharedAssets.DeviceImages

// MARK: - ViewsContainer

public struct ViewsContainer: PairingStepsContainer {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public var bluetoothUsageHint: (BluetoothUsageHint.ViewModel) -> BluetoothUsageHintView = BluetoothUsageHintView.init
    public var powerOnAndScanning: (PowerOnAndScanning.ViewModel) -> PowerOnAndScanningView = PowerOnAndScanningView.init
    public var enableBluetoothInSettings: () -> EnableBluetoothInSettingsView = EnableBluetoothInSettingsView.init
    public var bluetoothDeviceFound: (BluetoothDeviceFound.ViewModel) -> BluetoothDeviceFoundView = BluetoothDeviceFoundView.init
    public var askToConnect: (AskToConnect.ViewModel) -> AskToConnectView = AskToConnectView.init
    public var qrCodeScanner: (QRScanner.ViewModel) -> QRScannerView = QRScannerView.init
    public var listWiFiNetworks: (ListWiFiNetworks.ViewModel) -> ListWiFiNetworksView = ListWiFiNetworksView.init
    public var otherWiFiNetwork: (OtherWiFiNetwork.ViewModel) -> OtherWiFiNetworkView = OtherWiFiNetworkView.init
    public var enterWiFiPassword: (EnterWiFiPassword.ViewModel) -> EnterWiFiPasswordView = EnterWiFiPasswordView.init
    public var finishingSetup: () -> FinishingSetupView = FinishingSetupView.init
    public var pairingError: (PairingErrorScreen.ViewModel) -> PairingErrorScreenView = PairingErrorScreenView.init
    public var backButton: () -> NamiNavBackButton? = NamiSharedUIElements.NamiNavBackButton.init
}
