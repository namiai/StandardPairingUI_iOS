// Copyright (c) nami.ai
import Foundation
import I18n

// Define default value
public extension WordingProtocol {
    // MARK: - General
    var ok: String { get { return I18n.generalOk } }
    var next: String { get { return I18n.generalNext } }
    var cancel: String { get { return I18n.generalCancel } }
    var pairingNavigationBarTitle: String { get { return "" } }
    /// Requires string index parameter
    ///  Example: "Establishing connection with  %@…"
    func connectingToDevice(deviceName: String) -> String { return I18n.pairingLoadingDeviceConnecting(deviceName) }
    var basicSecuritySystem: String { return "Basic security system"}
    var homeSecuritySystem: String { return "Home security system" }
    
    // MARK: - Bluetooth Usage Hint View
    // Power On and Scanning View
    // Enable Bluetooth in Settings View
    var headerConnectToPower: String { get { return I18n.pairingBluetoothDeviceFoundHeaderConnectToPower } }
    var explainedReadyToPair: String { get { return I18n.pairingBluetoothDeviceFoundExplainedReadyToPair } }
    var headerContactSensor: String { get { return I18n.pairingScanningBleHeaderContactSensor } }
    
    // MARK: - Power On and Scanning View
    var scanning: String { get { return I18n.pairingPowerOnAndScanningScanning } }
    var askUserToWait: String { get { return I18n.pairingPowerOnAndScanningAskUserToWait } }
    
    // MARK: - Enable Bluetooth in Settings View
    var bluetoothDisabled: String { get { return I18n.pairingEnableBluetoothInSettingsBluetoothDisabled } }
    var enableBlueToothInSettingsHeader: String { get { return I18n.pairingEnableBluetoothInSettingsHeader } }
    var bluetoothIsOff: String { get { return I18n.paringScanDeviceBluetoothIsOffTitle } }
    var bluetoothIsOffDescription: String { get { return I18n.paringScanDeviceBluetoothIsOffDescription }}
    var bluetoothRestricted: String { get  { return I18n.paringScanDeviceBluetoothRestrictedTitle }}
    var bluetoothRestrictedDescription: String { get { return I18n.paringScanDeviceBluetoothRestrictedDescription } }
    var buttonSettings: String { get { return I18n.pairingEnableBluetoothInSettingsButtonSettings } }
    
    // MARK: - Enable Camera in Settings VIew
    var scanDeviceTitle: String { get { return I18n.pairingScanQrTitle } }
    var scanDeviceSubtitle: String { get { return I18n.pairingScanQrSubtitle } }
    var missingCameraPermissionTitle: String { get { return I18n.pairingScanQrcodeMissingCameraPermissionTitle } }
    var missingCameraPermissionDescription: String { get { return I18n.pairingScanQrcodeMissingCameraPermissionDescription } }
    var openSettings: String { get { return I18n.pairingEnableBluetoothInSettingsButtonSettings } }
    
    // MARK: - Bluetooth device found View
    var deviceFoundHeader1: String { get { return I18n.pairingBluetoothDeviceFoundHeader1 } }
    var deviceFoundHeader2: String { get { return I18n.pairingBluetoothDeviceFoundHeader2 } }
    /// "{device model} text"
    func askToNameHeader(productLabel: String) -> String { return I18n.pairingBluetoothDeviceFoundNameDeviceHeader(productLabel) }
    var nameYourDevice: String { get { return I18n.pairingBluetoothDeviceFoundNameYourDevice } }
    var nameDeviceExplained: String { get { return I18n.pairingBluetoothDeviceFoundNameDeviceExplained } }
    var nameAlreadyInUseError: String { get { return I18n.pairingBluetoothDeviceFoundNameAlreadyInUse } }
    
    // MARK: - Ask to Connect View
    var setUpAsBorderRouter: String { get { return I18n.pairingConnectWifiSetUpAsBorderRouter } }
    var settingUpThisDevice: String { get { return I18n.pairingConnectWifiSettingUpThisDevice } }
    var nonFirstThreadDeviceDescription1: String { get { return I18n.pairingAskToConnectNonFirstThreadDeviceDescription1 } }
    var nonFirstThreadDeviceDescription2: String { get { return I18n.pairingAskToConnectNonFirstThreadDeviceDescription2 } }
    func nonFirstThreadDeviceDescription3(zoneName: String) -> String { return I18n.pairingAskToConnectNonFirstThreadDeviceDescription3(zoneName) }
    func nonFirstWifiDeviceDescription1(zoneName: String) -> String { return I18n.pairingAskToConnectNonFirstWifiDeviceDescription1(zoneName) }
    var wifiDeviceMetricDistanceDescription: String { get { return I18n.pairingAskToConnectWifiDeviceMetricDistanceDescription } }
    var wifiDeviceImperialDistanceDescription: String { get { return I18n.pairingAskToConnectWifiDeviceImperialDistanceDescription } }
    var firstThreadDeviceDescription1: String { get { return I18n.pairingAskToConnectFirstThreadDeviceDescription1 } }
    var firstThreadDeviceDescription2: String { get { return I18n.pairingAskToConnectFirstThreadDeviceDescription2 } }
    var firstThreadDeviceDescription3: String { get { return I18n.pairingAskToConnectFirstThreadDeviceDescription3 } }
    func firstWifiDeviceDescription1(zoneName: String) -> String { return I18n.pairingAskToConnectFirstWifiDeviceDescription1(zoneName) }
    var firstWifiDeviceDescription2: String { get { return I18n.pairingAskToConnectFirstWifiDeviceDescription2 } }
    
    // MARK: - QR code scanner view
    var scanQRtitle: String { get { return I18n.pairingScanQrTitle } }
    var scanQRsubtitle: String { get { return I18n.pairingScanQrSubtitle } }
    var qrCodeError: String { get { return I18n.updateWifiQrCodeError } }
    var qrCodeMismatchError: String { get { return I18n.pairingScanQrCodeErrorDescription } }
    var tryAgainButton: String { get { return I18n.pairingErrorsActionTryAgain } }
    var scanQRexpandCamera: String { get { return I18n.pairingScanQrExpandCameraView } }
    var scanQRwhereIsQR: String { get { return I18n.pairingScanQrWhereIsQr } } 
    
    // MARK: - List Wifi networks view
    var connectWifiTitle: String { get { return I18n.pairingListWifiNetworksConnectWifiTitle } }
    var selectNetwork: String { get { return I18n.pairingListWifiNetworksSelectNetwork } }
    var networkNotFound: String { get { return I18n.pairingListWifiNetworksNoNetworksFound } }
    var availableNetworks: String { get { return I18n.pairingListWifiNetworksAvailableNetworks } }
    var otherNetworkButton: String { get { return I18n.pairingListWifiNetworksButtonOtherNetwork } }
    var otherNetworkTitle: String { get { return "Other network" }}
    
    // MARK: - Enter Wifi password
    func enterPassword(for networkName: String) -> String { return I18n.pairingEnterWifiPasswordEnterPasswordIos(networkName)}
    func enterPasswordHeaderTitle(networkName: String) -> String { return I18n.pairingEnterWifiPasswordHeader(networkName) }
    var passwordEntryFieldPlaceholder: String { get { return I18n.pairingEnterWifiPasswordPasswordPlaceholder } }
    var passwordEntryFieldHint: String { get { return I18n.pairingEnterWifiPasswordPasswordEntryFieldHint } }
    var buttonReadyToConnect: String { get { return I18n.pairingEnterWifiPasswordButtonReadyToConnect } }
    
    // MARK: - Password Retrieval alert
    var foundSavedPassword: String { get { return I18n.pairingListWifiNetworksFoundSavedPassword } }
    func useSavedPassword(networkName: String) -> String { return I18n.pairingListWifiNetworksUseSavedPassword(networkName) }
    var forget: String { get { return I18n.pairingListWifiNetworksForget } }
    
    // MARK: - Other wifi network view
    var otherWifiNetworkTitle: String { get { return I18n.pairingOtherWifiNetworkHeader } }
    var deviceConnectivityHint: String { get { return I18n.pairingOtherWifiNetworkDeviceConnectivityHint } }
    var networkNamePlaceholder: String { get { return I18n.pairingOtherWifiNetworkNetworkNamePlaceholder } }
    var passwordPlaceholder: String { get { return I18n.pairingEnterWifiPasswordPasswordPlaceholder } }
    var readyToConnectButton: String { get { return I18n.pairingEnterWifiPasswordButtonReadyToConnect } }
    
    // MARK: - Finishing setup
    var finishingSetupHeader: String { get { return I18n.pairingFinishingSetupHeader } }
    var gameOfPongText: String { get { return I18n.pairingFinishingSetupGameOfPong } }
    
    // MARK: - Positioning general
    var positioningNavigationTitle: String { get { return I18n.widarHeaderTitle } }
    
    // MARK: - Initial positioning screen
    var widarInfoTitle: String { get { return I18n.widarInfoTitle } }
    var widarInfoMustOptimisePosition: String { get { return I18n.widarInfoInfoMustOptimisePosition } }
    var widarInfoAvoidMovingWhenOptimized: String { get { return I18n.widarInfoInfoAvoidMovingWhenOptimized } }
    var nextButton: String { get { return I18n.generalNext } }
    
    // MARK: - How to position view
    var startPositioningButton: String { get { return I18n.widarRecommendationsButtonText } }
    var recommendationsTitle: String { get { return I18n.widarRecommendationsTitle } }
    var recommendationsInfoAttachBase: String { get { return I18n.widarRecommendationsInfoAttachBase } }
    var recommendationsInfoWireOnBack: String { get { return I18n.widarRecommendationsInfoWireOnBack } }
    var recommendationsInfoKeepAreaClear: String { get { return I18n.widarRecommendationsInfoKeepAreaClear } }
    
    // MARK: - Positioning guidance view
    var finishButton: String { get { return I18n.widarPositionFinishButton } }
    var cancelButton: String { get { return I18n.widarPositionCancelButton } }
    var positioningGuidanceTitle: String { get { return I18n.widarPositionTitle } }
    var guideMetric: String { get { return I18n.widarPositionGuideMetric } }
    var guideImperial: String { get { return I18n.widarPositionGuideImperial } }
    var statusLabel: String { get { return I18n.widarPositionStatusLabel } }
    var statusChecking: String { get { return I18n.widarPositionStatusLabel } }
    var statusMispositioned: String { get { return I18n.widarPositionStatusMispositioned } }
    var statusGettingBetter: String { get { return I18n.widarPositionStatusGettingBetter } }
    var statusOptimized: String { get { return I18n.widarPositionStatusOptimized } }
    var statusEstablishingConnection: String { get { return I18n.widarPositionStatusChecking } }
    var positioningTip: String { get { return I18n.widarPositionGuideMetric } }
    
    // MARK: - Positioning guidance: cancel positioning popup
    var cancelPopupTitle: String { get { return I18n.widarCancelPopupTitle } }
    var cancelPopupMessage: String { get { return I18n.widarCancelPopupMessage } }
    var cancelPopupBackToPositioningButton: String { get { return I18n.widarCancelPopupBackToPositioningButton } }
    var cancelPopupCancelButton: String { get { return I18n.widarCancelPopupCancelButton } }
    
    // MARK: - Positioning complete view
    var successTitle: String { get { return I18n.widarSuccessTitle } }
    func sucessContentMessage(deviceName: String) -> String { return I18n.widarSuccessContentMessage(deviceName) }
    var doneButton: String { get { return I18n.widarSuccessDoneButton } }
    
    // Error screens
    
    // MARK: - Pairing error view
    var errorOccurredTitle: String { get { return I18n.pairingErrorsErrorOccurredTitle } }
    var tryAgainActionTitle: String { get { return I18n.pairingErrorsActionTryAgain } }
    var restartActionTitle: String { get { return I18n.pairingErrorsActionRestart } }
    var ignoreActionTitle: String { get { return I18n.pairingErrorsActionIgnore } }
    var restartSetupActionTitle: String { get { return I18n.pairingErrorsActionRestartSetup } }
    var exitSetupActionTitle: String { get { return I18n.pairingExitSetup } }
    var scanDeviceAgainActionTitle: String { get { return I18n.pairingErrorsActionScanDeviceAgain } }
    
    // MARK:- Pairing error
    var pairingErrorNeedHelp: String { get { return I18n.pairingErrorsNeedHelp } }
    var pairingErrorOccurredTitle: String { get { return I18n.errorsPairingMachineUnexpectedState } }
    
    // MARK: - Pairing Machine error
    // MARK: - Pairing Machine error - title
    var pairingErrorDeviceWifiScanTitle: String { get { return I18n.errorsPairingErrorDeviceWifiScanError } }
    var pairingErrorDeviceWifiJoinIpTitle: String { get { return I18n.errorsPairingErrorDeviceWifiJoinIpError } }
    var pairingErrorDeviceWifiJoinPasswordTitle: String { get { return I18n.errorsPairingIncorrectWifiPasswordTitle } }
    var pairingErrorDeviceMismatchTitle: String { get { return I18n.pairingErrorsThreadSetupErrorDeviceMismatchTitle } }
    var pairingErrorConnectionTimeoutTitle: String { get { return I18n.pairingErrorsTimeoutTitle }}
    var pairingErrorBleDisconnectedTitle: String { get { return I18n.pairingErrorsBleDisconnectedTitle }}
    
    // MARK: - Pairing Machine error - description
    var pairingErrorUnexpectedStateDescription: String { get { return I18n.errorsPairingMachineUnexpectedState } }
    var pairingErrorUnexpectedMessageDescription: String { get { return I18n.errorsPairingMachineUnexpectedMessage } }
    var pairingErrorSeanceDescription: String { get { return I18n.errorsPairingMachineSeanceError } }
    var pairingErrorSerializationDescription: String { get { return I18n.errorsPairingMachineSerializationError } }
    var pairingErrorDeserializationDescription: String { get { return I18n.errorsPairingMachineDeserializationError } }
    var pairingErrorEncryptionErrorDescription: String { get { return I18n.errorsPairingMachineEncryptionError } }
    var pairingErrorDeviceMismatchDescription: String { get { return I18n.pairingErrorsDeviceSetupErrorDeviceMismatchDescription } }
    var pairingErrorKitDeviceMismatchDescription: String { get { return I18n.pairingErrorsThreadSetupErrorDeviceMismatchDescription } }
    var pairingErrorConnectionTimeoutDescription: String { get { return I18n.errorsPairingConnectionTimeOutDescription }}
    func pairingErrorBleDisconnectedDescription(deviceName: String) -> String { return I18n.errorsPairingBleDisconnectedDescription(deviceName) }
    var pairingErrorDeviceSecureSessionDescription: String { get { return I18n.errorsPairingErrorDeviceSecureSessionError } }
    var pairingErrorDeviceCloudChallengeDescription: String { get { return I18n.errorsPairingErrorDeviceCloudChallengeError } }
    var pairingErrorDeviceWifiScanDescription: String { get { return I18n.errorsPairingErrorDeviceWifiScanError } }
    var pairingErrorDeviceWifiJoinDescription: String { get { return I18n.errorsPairingErrorDeviceWifiJoinPasswordError } }
    var pairingErrorDeviceWifiJoinPasswordDescription: String { get { return I18n.errorsPairingErrorDeviceWifiJoinPasswordError } }
    var pairingErrorDeviceWifiJoinIpDescription: String { get { return I18n.errorsPairingErrorDeviceWifiJoinPasswordError } }
    var pairingErrorsUnableJoinThreadNetworksDescription1: String { get { return I18n.pairingErrorsContactSensorSetupErrorUnableJoinThreadNetworksDescription1 } }
    func pairingErrorsUnableJoinThreadNetworksDescription2(zoneName: String) -> String { return I18n.pairingErrorsContactSensorSetupErrorUnableJoinThreadNetworksDescription2(zoneName) }
    var pairingErrorDeviceUnknownUnrecognizedDescription: String { get { return I18n.errorsPairingErrorDeviceUnknownUnrecognized } }
    
    // MARK: - Pairing Thread error
    // MARK: - Pairing Thread error - title
    var pairingThreadErrorDatasetMissingTitle: String { get { return I18n.pairingErrorsThreadSetupErrorMissingThreadCredentials } }
    var pairingThreadErrorThreadNetworkNotFoundTitle: String { get { return I18n.pairingErrorsThreadSetupErrorNoThreadNetworksFoundTitle } }
    
    // MARK: - Pairing Thread error - description
    var pairingThreadErrorDatasetMissingDescription: String { get { return I18n.errorsPairingThreadSetupErrorThreadOperationalDatasetMissing } }
    func pairingThreadErrorContactSensorNoThreadNetworksFoundDescription1(zoneName: String) -> String { return I18n.pairingErrorsContactSensorSetupErrorNoThreadNetworksFoundDescription1(zoneName) }
    var pairingThreadErrorContactSensorNoThreadNetworksFoundDescription2: String { get { return I18n.pairingErrorsContactSensorSetupErrorNoThreadNetworksFoundDescription2 } }
    func pairingThreadErrorNoThreadNetworksFoundDescription(zoneName: String) -> String { return I18n.pairingErrorsThreadSetupErrorNoThreadNetworksFoundDescription(zoneName) }
    
    // MARK: - Positioning error view
    var positioningErrorTitle: String { get { return I18n.widarErrorTitle } }
    var deviceNotFoundMessage: String { get { return I18n.widarErrorDeviceNotFoundMessage } }
    var retryPositioningButton: String { get { return I18n.widarErrorRetryButton } }
    var exitPositioningButton: String { get { return I18n.widarPositionTertiaryButtonText } }
    
    // MARK: - URLs
    var urlNotPulsingBlue: String { get { return "https://support.nami.ai/hc/en-us/articles/33743569254809-My-device-s-LED-is-not-pulsing-during-setup" } }
    var urlNamiThreadTopology: String { get { return "https://support.nami.ai/hc/en-us/articles/31306413218201-nami-Thread-topology" } }
    var urlNotConnectToThread: String { get { return "https://support.nami.ai/hc/en-us/articles/34191094200473-My-device-can-not-connect-to-the-Thread-network" } }
    
    
    
    // MARK: - FAQ terms
    var pairingScanningBleFaq: String { get { return I18n.pairingScanningBleFaq } }
    var pairingScanningBleFaqDoorSensor: String { get { return I18n.pairingScanDeviceTheLedLightIsNotPulsing } }
}
