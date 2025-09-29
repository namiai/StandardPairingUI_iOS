// Copyright (c) nami.ai

import Foundation
import I18n

// Define default value
public extension WordingProtocol {
    // MARK: - General

    var ok: String { return I18n.generalOk }
    var next: String { return I18n.generalNext }
    var cancel: String { return I18n.generalCancel }
    var pairingNavigationBarTitle: String { return I18n.pairingDeviceSetupNavigationTitle }
    var kitNameNavigationBarTitle: String { return "" }
    /// Requires string index parameter
    ///  Example: "Establishing connection with  %@…"
    func connectingToDevice(deviceName: String) -> String { return I18n.pairingLoadingDeviceConnecting(deviceName) }
    var basicSecuritySystem: String { return "Basic security system" }
    var homeSecuritySystem: String { return "Home security system" }

    // MARK: - Bluetooth Usage Hint View

    // Power On and Scanning View
    // Enable Bluetooth in Settings View
    var headerConnectToPower: String { return I18n.pairingBluetoothDeviceFoundHeaderConnectToPower }
    var explainedReadyToPair: String { return I18n.pairingBluetoothDeviceFoundExplainedReadyToPair }
    var headerContactSensor: String { return I18n.pairingScanningBleHeaderContactSensor }
    var headerKeypad: String { return I18n.pairingScanningBleHeaderKeypad }

    // MARK: - Power On and Scanning View

    var scanning: String { return I18n.pairingPowerOnAndScanningScanning }
    var askUserToWait: String { return I18n.pairingPowerOnAndScanningAskUserToWait }

    // MARK: - Enable Bluetooth in Settings View

    var bluetoothDisabled: String { return I18n.pairingEnableBluetoothInSettingsBluetoothDisabled }
    var enableBlueToothInSettingsHeader: String { return I18n.pairingEnableBluetoothInSettingsHeader }
    var bluetoothIsOff: String { return I18n.paringScanDeviceBluetoothIsOffTitle }
    var bluetoothIsOffDescription: String { return I18n.paringScanDeviceBluetoothIsOffDescription }
    var bluetoothRestricted: String { return I18n.paringScanDeviceBluetoothRestrictedTitle }
    var bluetoothRestrictedDescription: String { return I18n.paringScanDeviceBluetoothRestrictedDescription }
    var buttonSettings: String { return I18n.pairingEnableBluetoothInSettingsButtonSettings }

    // MARK: - Enable Camera in Settings VIew

    var scanDeviceTitle: String { return I18n.pairingScanQrTitle }
    var scanDeviceSubtitle: String { return I18n.pairingScanQrSubtitle }
    var missingCameraPermissionTitle: String { return I18n.pairingScanQrcodeMissingCameraPermissionTitle }
    var missingCameraPermissionDescription: String { return I18n.pairingScanQrcodeMissingCameraPermissionDescription }
    var openSettings: String { return I18n.pairingEnableBluetoothInSettingsButtonSettings }

    // MARK: - Bluetooth device found View

    var deviceFoundHeader1: String { return I18n.pairingBluetoothDeviceFoundHeader1 }
    var deviceFoundHeader2: String { return I18n.pairingBluetoothDeviceFoundHeader2 }
    /// "{device model} text"
    func askToNameHeader(productLabel: String) -> String { return I18n.pairingBluetoothDeviceFoundNameDeviceHeader(productLabel) }
    var nameYourDevice: String { return I18n.pairingBluetoothDeviceFoundNameYourDevice }
    var nameDeviceExplained: String { return I18n.pairingBluetoothDeviceFoundNameDeviceExplained }
    var nameAlreadyInUseError: String { return I18n.pairingBluetoothDeviceFoundNameAlreadyInUse }

    // MARK: - Ask to Connect View

    var setUpAsBorderRouter: String { return I18n.pairingConnectWifiSetUpAsBorderRouter }
    var settingUpThisDevice: String { return I18n.pairingConnectWifiSettingUpThisDevice }
    var nonFirstThreadDeviceDescription1: String { return I18n.pairingAskToConnectNonFirstThreadDeviceDescription1 }
    var nonFirstThreadDeviceDescription2: String { return I18n.pairingAskToConnectNonFirstThreadDeviceDescription2 }
    func nonFirstThreadDeviceDescription3(zoneName: String) -> String { return I18n.pairingAskToConnectNonFirstThreadDeviceDescription3(zoneName) }
    func nonFirstWifiDeviceDescription1(zoneName: String) -> String { return I18n.pairingAskToConnectNonFirstWifiDeviceDescription1(zoneName) }
    var wifiDeviceMetricDistanceDescription: String { return I18n.pairingAskToConnectWifiDeviceMetricDistanceDescription }
    var wifiDeviceImperialDistanceDescription: String { return I18n.pairingAskToConnectWifiDeviceImperialDistanceDescription }
    var firstThreadDeviceDescription1: String { return I18n.pairingAskToConnectFirstThreadDeviceDescription1 }
    var firstThreadDeviceDescription2: String { return I18n.pairingAskToConnectFirstThreadDeviceDescription2 }
    var firstThreadDeviceDescription3: String { return I18n.pairingAskToConnectFirstThreadDeviceDescription3 }
    func firstWifiDeviceDescription1(zoneName: String) -> String { return I18n.pairingAskToConnectFirstWifiDeviceDescription1(zoneName) }
    var firstWifiDeviceDescription2: String { return I18n.pairingAskToConnectFirstWifiDeviceDescription2 }

    // MARK: - QR code scanner view

    var scanQRtitle: String { return I18n.pairingScanQrTitle }
    var scanQRsubtitle: String { return I18n.pairingScanQrSubtitle }
    var qrCodeError: String { return I18n.updateWifiQrCodeError }
    var qrCodeMismatchError: String { return I18n.pairingScanQrCodeErrorDescription }
    var tryAgainButton: String { return I18n.pairingErrorsActionTryAgain }
    var scanQRexpandCamera: String { return I18n.pairingScanQrExpandCameraView }
    var scanQRwhereIsQR: String { return I18n.pairingScanQrWhereIsQr }

    // MARK: - List Wifi networks view

    var connectWifiTitle: String { return I18n.pairingListWifiNetworksConnectWifiTitle }
    var selectNetwork: String { return I18n.pairingListWifiNetworksSelectNetwork }
    var networkNotFound: String { return I18n.pairingListWifiNetworksNoNetworksFound }
    var availableNetworks: String { return I18n.pairingListWifiNetworksAvailableNetworks }
    var otherNetworkButton: String { return I18n.pairingListWifiNetworksButtonOtherNetwork }
    var otherNetworkTitle: String { return I18n.pairingOtherNetworkTitle }

    // MARK: - Enter Wifi password

    func enterPassword(for networkName: String) -> String { return I18n.pairingEnterWifiPasswordEnterPasswordIos(networkName) }
    func enterPasswordHeaderTitle(networkName: String) -> String { return I18n.pairingEnterWifiPasswordHeader(networkName) }
    var passwordEntryFieldPlaceholder: String { return I18n.pairingEnterWifiPasswordPasswordPlaceholder }
    var passwordEntryFieldHint: String { return I18n.pairingEnterWifiPasswordPasswordEntryFieldHint }
    var buttonReadyToConnect: String { return I18n.pairingEnterWifiPasswordButtonReadyToConnect }

    // MARK: - Password Retrieval alert

    var foundSavedPassword: String { return I18n.pairingListWifiNetworksFoundSavedPassword }
    func useSavedPassword(networkName: String) -> String { return I18n.pairingListWifiNetworksUseSavedPassword(networkName) }
    var forget: String { return I18n.pairingListWifiNetworksForget }

    // MARK: - Other wifi network view

    var otherWifiNetworkTitle: String { return I18n.pairingOtherWifiNetworkHeader }
    var deviceConnectivityHint: String { return I18n.pairingOtherWifiNetworkDeviceConnectivityHint }
    var networkNamePlaceholder: String { return I18n.pairingOtherWifiNetworkNetworkNamePlaceholder }
    var passwordPlaceholder: String { return I18n.pairingEnterWifiPasswordPasswordPlaceholder }
    var readyToConnectButton: String { return I18n.pairingEnterWifiPasswordButtonReadyToConnect }

    // MARK: - Finishing setup

    var finishingSetupHeader: String { return I18n.pairingFinishingSetupHeader }
    var gameOfPongText: String { return I18n.pairingFinishingSetupGameOfPong }

    // MARK: - Positioning general

    var positioningNavigationTitle: String { return I18n.widarHeaderTitle }

    // MARK: - Initial positioning screen

    var widarInfoTitle: String { return I18n.widarInfoTitle }
    var widarInfoMustOptimisePosition: String { return I18n.widarInfoInfoMustOptimisePosition }
    var widarInfoAvoidMovingWhenOptimized: String { return I18n.widarInfoInfoAvoidMovingWhenOptimized }
    var nextButton: String { return I18n.generalNext }

    // MARK: - How to position view

    var startPositioningButton: String { return I18n.widarRecommendationsButtonText }
    var recommendationsTitle: String { return I18n.widarRecommendationsTitle }
    var recommendationsInfoAttachBase: String { return I18n.widarRecommendationsInfoAttachBase }
    var recommendationsInfoWireOnBack: String { return I18n.widarRecommendationsInfoWireOnBack }
    var recommendationsInfoKeepAreaClear: String { return I18n.widarRecommendationsInfoKeepAreaClear }

    // MARK: - Positioning guidance view

    var finishButton: String { return I18n.widarPositionFinishButton }
    var cancelButton: String { return I18n.widarPositionCancelButton }
    var positioningGuidanceTitle: String { return I18n.widarPositionTitle }
    var guideMetric: String { return I18n.widarPositionGuideMetric }
    var guideImperial: String { return I18n.widarPositionGuideImperial }
    var statusLabel: String { return I18n.widarPositionStatusLabel }
    var statusChecking: String { return I18n.widarPositionStatusLabel }
    var statusMispositioned: String { return I18n.widarPositionStatusMispositioned }
    var statusGettingBetter: String { return I18n.widarPositionStatusGettingBetter }
    var statusOptimized: String { return I18n.widarPositionStatusOptimized }
    var statusEstablishingConnection: String { return I18n.widarPositionStatusChecking }
    var positioningTip: String { return I18n.widarPositionGuideMetric }

    // MARK: - Positioning guidance: cancel positioning popup

    var cancelPopupTitle: String { return I18n.widarCancelPopupTitle }
    var cancelPopupMessage: String { return I18n.widarCancelPopupMessage }
    var cancelPopupBackToPositioningButton: String { return I18n.widarCancelPopupBackToPositioningButton }
    var cancelPopupCancelButton: String { return I18n.widarCancelPopupCancelButton }

    // MARK: - Positioning complete view

    var successTitle: String { return I18n.widarSuccessTitle }
    func sucessContentMessage(deviceName: String) -> String { return I18n.widarSuccessContentMessage(deviceName) }
    var doneButton: String { return I18n.widarSuccessDoneButton }

    // Error screens

    // MARK: - Pairing error view

    var errorOccurredTitle: String { return I18n.pairingErrorsErrorOccurredTitle }
    var tryAgainActionTitle: String { return I18n.pairingErrorsActionTryAgain }
    var restartActionTitle: String { return I18n.pairingErrorsActionRestart }
    var ignoreActionTitle: String { return I18n.pairingErrorsActionIgnore }
    var restartSetupActionTitle: String { return I18n.pairingErrorsActionRestartSetup }
    var exitSetupActionTitle: String { return I18n.pairingExitSetup }
    var scanDeviceAgainActionTitle: String { return I18n.pairingErrorsActionScanDeviceAgain }

    // MARK: - Pairing error

    var pairingErrorNeedHelp: String { return I18n.pairingErrorsNeedHelp }
    var pairingErrorOccurredTitle: String { return I18n.errorsPairingMachineUnexpectedState }

    // MARK: - Pairing Machine error

    // MARK: - Pairing Machine error - title

    var pairingErrorDeviceWifiScanTitle: String { return I18n.errorsPairingErrorDeviceWifiScanError }
    var pairingErrorDeviceWifiJoinIpTitle: String { return I18n.errorsPairingErrorDeviceWifiJoinIpError }
    var pairingErrorDeviceWifiJoinPasswordTitle: String { return I18n.errorsPairingIncorrectWifiPasswordTitle }
    var pairingErrorDeviceMismatchTitle: String { return I18n.pairingErrorsThreadSetupErrorDeviceMismatchTitle }
    var pairingErrorConnectionTimeoutTitle: String { return I18n.pairingErrorsTimeoutTitle }
    var pairingErrorBleDisconnectedTitle: String { return I18n.pairingErrorsBleDisconnectedTitle }

    // MARK: - Pairing Machine error - description

    var pairingErrorUnexpectedStateDescription: String { return I18n.errorsPairingMachineUnexpectedState }
    var pairingErrorUnexpectedMessageDescription: String { return I18n.errorsPairingMachineUnexpectedMessage }
    var pairingErrorSeanceDescription: String { return I18n.errorsPairingMachineSeanceError }
    var pairingErrorSerializationDescription: String { return I18n.errorsPairingMachineSerializationError }
    var pairingErrorDeserializationDescription: String { return I18n.errorsPairingMachineDeserializationError }
    var pairingErrorEncryptionErrorDescription: String { return I18n.errorsPairingMachineEncryptionError }
    var pairingErrorDeviceMismatchDescription: String { return I18n.pairingErrorsDeviceSetupErrorDeviceMismatchDescription }
    var pairingErrorKitDeviceMismatchDescription: String { return I18n.pairingErrorsThreadSetupErrorDeviceMismatchDescription }
    var pairingErrorConnectionTimeoutDescription: String { return I18n.errorsPairingConnectionTimeOutDescription }
    func pairingErrorBleDisconnectedDescription(deviceName: String) -> String { return I18n.errorsPairingBleDisconnectedDescription(deviceName) }
    var pairingErrorDeviceSecureSessionDescription: String { return I18n.errorsPairingErrorDeviceSecureSessionError }
    var pairingErrorDeviceCloudChallengeDescription: String { return I18n.errorsPairingErrorDeviceCloudChallengeError }
    var pairingErrorDeviceWifiScanDescription: String { return I18n.errorsPairingErrorDeviceWifiScanError }
    var pairingErrorDeviceWifiJoinDescription: String { return I18n.errorsPairingErrorDeviceWifiJoinPasswordError }
    var pairingErrorDeviceWifiJoinPasswordDescription: String { return I18n.errorsPairingErrorDeviceWifiJoinPasswordError }
    var pairingErrorDeviceWifiJoinIpDescription: String { return I18n.errorsPairingErrorDeviceWifiJoinPasswordError }
    var pairingErrorsUnableJoinThreadNetworksDescription1: String { return I18n.pairingErrorsContactSensorSetupErrorUnableJoinThreadNetworksDescription1 }
    func pairingErrorsUnableJoinThreadNetworksDescription2(zoneName: String) -> String { return I18n.pairingErrorsContactSensorSetupErrorUnableJoinThreadNetworksDescription2(zoneName) }
    var pairingErrorDeviceUnknownUnrecognizedDescription: String { return I18n.errorsPairingErrorDeviceUnknownUnrecognized }

    // MARK: - Pairing Thread error

    // MARK: - Pairing Thread error - title

    var pairingThreadErrorDatasetMissingTitle: String { return I18n.pairingErrorsThreadSetupErrorMissingThreadCredentials }
    var pairingThreadErrorThreadNetworkNotFoundTitle: String { return I18n.pairingErrorsThreadSetupErrorNoThreadNetworksFoundTitle }
    var pairingErrorMobilePhoneIsNotConnectedToWifi: String { return I18n.pairingErrorMobilePhoneIsNotConnectedToWifi }

    // MARK: - Pairing Thread error - description

    var pairingThreadErrorDatasetMissingDescription: String { return I18n.errorsPairingThreadSetupErrorThreadOperationalDatasetMissing }
    func pairingThreadErrorContactSensorNoThreadNetworksFoundDescription1(zoneName: String) -> String { return I18n.pairingErrorsContactSensorSetupErrorNoThreadNetworksFoundDescription1(zoneName) }
    var pairingThreadErrorContactSensorNoThreadNetworksFoundDescription2: String { return I18n.pairingErrorsContactSensorSetupErrorNoThreadNetworksFoundDescription2 }
    func pairingThreadErrorNoThreadNetworksFoundDescription(zoneName: String) -> String { return I18n.pairingErrorsThreadSetupErrorNoThreadNetworksFoundDescription(zoneName) }
    var pairingErrorMobilePhoneIsNotConnectedToWifiDescription: String { return I18n.pairingErrorMobilePhoneIsNotConnectedToWifiDescription }
    var pairingErrorNoThreadBorderRouterInPlace: String { return I18n.pairingErrorNoThreadBorderRouterInPlace }
    var pairingErrorAllBorderRouterOffline: String { return I18n.pairingErrorAllBorderRouterOffline }

    // MARK: - Positioning error view

    var positioningErrorTitle: String { return I18n.widarErrorTitle }
    var deviceNotFoundMessage: String { return I18n.widarErrorDeviceNotFoundMessage }
    var retryPositioningButton: String { return I18n.widarErrorRetryButton }
    var exitPositioningButton: String { return I18n.widarPositionTertiaryButtonText }

    // MARK: - URLs

    var urlNotPulsingBlue: String { return "https://support.nami.ai/hc/en-us/articles/33743569254809-My-device-s-LED-is-not-pulsing-during-setup" }
    var urlNamiThreadTopology: String { return "https://support.nami.ai/hc/en-us/articles/43618431475353-What-is-Thread" }
    var urlNotConnectToThread: String { return "https://support.nami.ai/hc/en-us/articles/34191094200473-My-device-can-not-connect-to-the-Thread-network" }

    // MARK: - FAQ terms

    var pairingScanningBleFaq: String { return I18n.pairingScanningBleFaq }
    var pairingScanningBleFaqDoorSensor: String { return I18n.pairingScanDeviceTheLedLightIsNotPulsing }
}
