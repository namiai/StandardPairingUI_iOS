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

    public var powerOnAndScanning: (PowerOnAndScanning.ViewModel) -> PowerOnAndScanningView = PowerOnAndScanningView.init
    public var enableCameraInSettings: (String) -> EnableCameraInSettingsView = EnableCameraInSettingsView.init
    public var bluetoothDeviceFound: (BluetoothDeviceFound.ViewModel) -> BluetoothDeviceFoundView = BluetoothDeviceFoundView.init
    public var qrCodeScanner: (QRScanner.ViewModel) -> QRScannerView = QRScannerView.init
    public var listWiFiNetworks: (ListWiFiNetworks.ViewModel) -> ListWiFiNetworksView = ListWiFiNetworksView.init
    public var otherWiFiNetwork: (OtherWiFiNetwork.ViewModel) -> OtherWiFiNetworkView = OtherWiFiNetworkView.init
    public var enterWiFiPassword: (EnterWiFiPassword.ViewModel) -> EnterWiFiPasswordView = EnterWiFiPasswordView.init
    public var finishingSetup: (String) -> FinishingSetupView = FinishingSetupView.init
    public var howToPosition: (HowToPosition.ViewModel) -> HowToPositionView = HowToPositionView.init
    public var initialPositioningScreen: (InitialScreen.ViewModel) -> InitialScreenView = InitialScreenView.init
    public var positioningGuidance: (PositioningGuidance.ViewModel) -> PositioningGuidanceView = PositioningGuidanceView.init
    public var positioningComplete: (PositioningComplete.ViewModel) -> PositioningCompleteView = PositioningCompleteView.init
    public var positionError: (ErrorScreen.ViewModel) -> ErrorScreenView = ErrorScreenView.init
    public var pairingError: (PairingErrorScreen.ViewModel) -> PairingErrorScreenView = PairingErrorScreenView.init
    public var backButton: () -> CircleButton? = CircleButton.init
}
