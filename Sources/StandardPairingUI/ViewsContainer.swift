// Copyright (c) nami.ai

import Tomonari
import SwiftUI

// MARK: - ViewsContainer

public struct ViewsContainer: PairingStepsContainer {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    // Associated type conformance
    public typealias ViewForPowerOnAndScanning = PowerOnAndScanningView
    public typealias ViewForEnableCameraInSettings = EnableCameraInSettingsView
    public typealias ViewForBluetoothDeviceFound = BluetoothDeviceFoundView
    public typealias ViewForQRCodeScanner = QRScannerView
    public typealias ViewForListWiFiNetworks = ListWiFiNetworksView
    public typealias ViewForOtherWiFiNetwork = OtherWiFiNetworkView
    public typealias ViewForEnterWiFiPassword = EnterWiFiPasswordView
    public typealias ViewForFinishingSetup = FinishingSetupView
    public typealias ViewForPairingError = PairingErrorScreenView
    public typealias BackButtonView = NoView

    // Deprecated associated types
    public typealias ViewForPositioningErrorScreen = ErrorScreenView
    public typealias ViewForHowToPosition = HowToPositionView
    public typealias ViewForInitialPositioningScreen = InitialScreenView
    public typealias ViewForPositioningGuidance = PositioningGuidanceView
    public typealias ViewForPositioningComplete = PositioningCompleteView

    public var backButton: () -> NoView? = { nil }

    public var powerOnAndScanning: (PowerOnAndScanning.ViewModel) -> PowerOnAndScanningView = PowerOnAndScanningView.init
    public var enableCameraInSettings: (String) -> EnableCameraInSettingsView = EnableCameraInSettingsView.init
    public var bluetoothDeviceFound: (BluetoothDeviceFound.ViewModel) -> BluetoothDeviceFoundView = BluetoothDeviceFoundView.init
    public var qrCodeScanner: (QRScanner.ViewModel) -> QRScannerView = QRScannerView.init
    public var listWiFiNetworks: (ListWiFiNetworks.ViewModel) -> ListWiFiNetworksView = ListWiFiNetworksView.init
    public var otherWiFiNetwork: (OtherWiFiNetwork.ViewModel) -> OtherWiFiNetworkView = OtherWiFiNetworkView.init
    public var enterWiFiPassword: (EnterWiFiPassword.ViewModel) -> EnterWiFiPasswordView = EnterWiFiPasswordView.init
    public var finishingSetup: (String) -> FinishingSetupView = FinishingSetupView.init
    public var pairingError: (PairingErrorScreen.ViewModel) -> PairingErrorScreenView = PairingErrorScreenView.init

    // Deprecated fields
    public var howToPosition: (HowToPosition.ViewModel) -> HowToPositionView = HowToPositionView.init
    public var initialPositioningScreen: (InitialScreen.ViewModel) -> InitialScreenView = InitialScreenView.init
    public var positioningGuidance: (PositioningGuidance.ViewModel) -> PositioningGuidanceView = PositioningGuidanceView.init
    public var positioningComplete: (PositioningComplete.ViewModel) -> PositioningCompleteView = PositioningCompleteView.init
    public var positionError: (ErrorScreen.ViewModel) -> ErrorScreenView = ErrorScreenView.init
}
