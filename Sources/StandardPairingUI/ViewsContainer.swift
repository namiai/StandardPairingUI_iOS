// Copyright (c) nami.ai

import CommonTypes
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

typealias NamiTextStyle = NamiSharedUIElements.NamiTextStyle
typealias DeviceImages = SharedAssets.DeviceImages
typealias DeviceQRCodeLocationImages = SharedAssets.DeviceQRCodeLocationImages

// MARK: - ViewsContainer

public struct ViewsContainer: PairingStepsContainer {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public var powerOnAndScanning: @MainActor @Sendable (PowerOnAndScanning.ViewModel) -> PowerOnAndScanningView = PowerOnAndScanningView.init
    public var enableCameraInSettings: @MainActor @Sendable (String) -> EnableCameraInSettingsView = EnableCameraInSettingsView.init
    public var bluetoothDeviceFound: @MainActor @Sendable (BluetoothDeviceFound.ViewModel) -> BluetoothDeviceFoundView = BluetoothDeviceFoundView.init
    public var qrCodeScanner: @MainActor @Sendable (QRScanner.ViewModel) -> QRScannerView = QRScannerView.init
    public var listWiFiNetworks: @MainActor @Sendable (ListWiFiNetworks.ViewModel) -> ListWiFiNetworksView = ListWiFiNetworksView.init
    public var otherWiFiNetwork: @MainActor @Sendable (OtherWiFiNetwork.ViewModel) -> OtherWiFiNetworkView = OtherWiFiNetworkView.init
    public var enterWiFiPassword: @MainActor @Sendable (EnterWiFiPassword.ViewModel) -> EnterWiFiPasswordView = EnterWiFiPasswordView.init
    public var finishingSetup: @MainActor @Sendable (String) -> FinishingSetupView = FinishingSetupView.init
    public var pairingError: @MainActor @Sendable (PairingErrorScreen.ViewModel) -> PairingErrorScreenView = PairingErrorScreenView.init
    public var backButton: @MainActor @Sendable () -> CircleButton? = CircleButton.init
}
