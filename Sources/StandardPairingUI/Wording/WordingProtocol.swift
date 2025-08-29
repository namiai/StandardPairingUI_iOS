// Copyright (c) nami.ai

import Foundation

public protocol WordingProtocol {
    // MARK: - General 
    var ok: String { get }
    var next: String { get }
    var cancel: String { get }
    var pairingNavigationBarTitle: String { get set }
    /// Requires string index parameter
    ///  Example: "Establishing connection with  %@…"
    func connectingToDevice(deviceName: String) -> String
    var basicSecuritySystem: String { get }
    var homeSecuritySystem: String { get }
    
    // MARK: - Bluetooth Usage Hint View
    // Power On and Scanning View
    // Enable Bluetooth in Settings View
    var headerConnectToPower: String { get }
    var explainedReadyToPair: String { get }
    var headerContactSensor: String { get }
    var headerKeypad: String { get }
    
    // MARK: - Power On and Scanning View
    var scanning: String { get }
    var askUserToWait: String { get }
    
    // MARK: - Enable Bluetooth in Settings View 
    var bluetoothDisabled: String { get }
    var enableBlueToothInSettingsHeader: String { get }
    var bluetoothIsOff: String { get }
    var bluetoothIsOffDescription: String { get }
    var bluetoothRestricted: String { get }
    var bluetoothRestrictedDescription: String { get }
    var buttonSettings: String { get }
    
    // MARK: - Enable Camera in Settings VIew 
    var scanDeviceTitle: String { get }
    var scanDeviceSubtitle: String { get }
    var missingCameraPermissionTitle: String { get }
    var missingCameraPermissionDescription: String { get }
    var openSettings: String { get }
    
    // MARK: - Bluetooth device found View
    var deviceFoundHeader1: String { get }
    var deviceFoundHeader2: String { get }
    /// "{device model} text"
    func askToNameHeader(productLabel: String) -> String
    var nameYourDevice: String { get }
    var nameDeviceExplained: String { get }
    var nameAlreadyInUseError: String { get }
    
    // MARK: - Ask to Connect View
    var setUpAsBorderRouter: String { get }
    var settingUpThisDevice: String { get }
    var nonFirstThreadDeviceDescription1: String { get }
    var nonFirstThreadDeviceDescription2: String { get }
    func nonFirstThreadDeviceDescription3(zoneName: String) -> String
    func nonFirstWifiDeviceDescription1(zoneName: String) -> String
    var wifiDeviceMetricDistanceDescription: String { get }
    var wifiDeviceImperialDistanceDescription: String { get }
    var firstThreadDeviceDescription1: String { get }
    var firstThreadDeviceDescription2: String { get }
    var firstThreadDeviceDescription3: String { get }
    func firstWifiDeviceDescription1(zoneName: String) -> String
    var firstWifiDeviceDescription2: String { get }
    
    // MARK: - QR code scanner view 
    var scanQRtitle: String { get }
    var scanQRsubtitle: String { get }
    var qrCodeError: String { get }
    var qrCodeMismatchError: String { get }
    var tryAgainButton: String { get }
    var scanQRexpandCamera: String { get }
    var scanQRwhereIsQR: String { get }
    
    // MARK: - List Wifi networks view
    var connectWifiTitle: String { get }
    var selectNetwork: String { get }
    var networkNotFound: String { get }
    var availableNetworks: String { get }
    var otherNetworkButton: String { get }
    var otherNetworkTitle: String { get }
    
    // MARK: - Enter Wifi password 
    func enterPassword(for networkName: String) -> String
    func enterPasswordHeaderTitle(networkName: String) -> String
    var passwordEntryFieldPlaceholder: String { get }
    var passwordEntryFieldHint: String { get }
    var buttonReadyToConnect: String { get }
    
    // MARK: - Password Retrieval alert
    var foundSavedPassword: String { get }
    func useSavedPassword(networkName: String) -> String
    var forget: String { get }
    
    // MARK: - Other wifi network view 
    var otherWifiNetworkTitle: String { get }
    var deviceConnectivityHint: String { get }
    var networkNamePlaceholder: String { get }
    var passwordPlaceholder: String { get }
    var readyToConnectButton: String { get }
    
    // MARK: - Finishing setup
    var finishingSetupHeader: String { get }
    var gameOfPongText: String { get }
    
    // MARK: - Positioning general
    var positioningNavigationTitle: String { get }
    
    // MARK: - Initial positioning screen
    var widarInfoTitle: String { get }
    var widarInfoMustOptimisePosition: String { get }
    var widarInfoAvoidMovingWhenOptimized: String { get }
    var nextButton: String { get }
    
    // MARK: - How to position view
    var startPositioningButton: String { get }
    var recommendationsTitle: String { get }
    var recommendationsInfoAttachBase: String { get }
    var recommendationsInfoWireOnBack: String { get }
    var recommendationsInfoKeepAreaClear: String { get }
    
    // MARK: - Positioning guidance view
    var finishButton: String { get }
    var cancelButton: String { get }
    var positioningGuidanceTitle: String { get }
    var guideMetric: String { get }
    var guideImperial: String { get }
    var statusLabel: String { get }
    var statusChecking: String { get }
    var statusMispositioned: String { get }
    var statusGettingBetter: String { get }
    var statusOptimized: String { get }
    var statusEstablishingConnection: String { get }
    var positioningTip: String { get }
    
    // MARK: - Positioning guidance: cancel positioning popup 
    var cancelPopupTitle: String { get }
    var cancelPopupMessage: String { get }
    var cancelPopupBackToPositioningButton: String { get }
    var cancelPopupCancelButton: String { get }
    
    // MARK: - Positioning complete view
    var successTitle: String { get }
    func sucessContentMessage(deviceName: String) -> String
    var doneButton: String { get }
    
    // Error screens
    
    // MARK: - Pairing error view
    var errorOccurredTitle: String { get }
    var tryAgainActionTitle: String { get }
    var restartActionTitle: String { get }
    var ignoreActionTitle: String { get }
    var restartSetupActionTitle: String { get }
    var exitSetupActionTitle: String { get }
    var scanDeviceAgainActionTitle: String { get }
    
    // MARK:- Pairing error
    var pairingErrorNeedHelp: String { get }
    var pairingErrorOccurredTitle: String { get }
    
    // MARK: - Pairing Machine error
    // MARK: - Pairing Machine error - title
    var pairingErrorDeviceWifiScanTitle: String { get }
    var pairingErrorDeviceWifiJoinIpTitle: String { get }
    var pairingErrorDeviceWifiJoinPasswordTitle: String { get }
    var pairingErrorDeviceMismatchTitle: String { get }
    var pairingErrorConnectionTimeoutTitle: String { get }
    var pairingErrorBleDisconnectedTitle: String { get }
    
    // MARK: - Pairing Machine error - description
    var pairingErrorUnexpectedStateDescription: String { get }
    var pairingErrorUnexpectedMessageDescription: String { get }
    var pairingErrorSeanceDescription: String { get }
    var pairingErrorSerializationDescription: String { get }
    var pairingErrorDeserializationDescription: String { get }
    var pairingErrorEncryptionErrorDescription: String { get }
    var pairingErrorDeviceMismatchDescription: String { get }
    var pairingErrorKitDeviceMismatchDescription: String { get }
    var pairingErrorConnectionTimeoutDescription: String { get }
    func pairingErrorBleDisconnectedDescription(deviceName: String) -> String 
    var pairingErrorDeviceSecureSessionDescription: String { get }
    var pairingErrorDeviceCloudChallengeDescription: String { get }
    var pairingErrorDeviceWifiScanDescription: String { get }
    var pairingErrorDeviceWifiJoinDescription: String { get }
    var pairingErrorDeviceWifiJoinPasswordDescription: String { get }
    var pairingErrorDeviceWifiJoinIpDescription: String { get }
    var pairingErrorsUnableJoinThreadNetworksDescription1: String { get }
    func pairingErrorsUnableJoinThreadNetworksDescription2(zoneName: String) -> String
    var pairingErrorDeviceUnknownUnrecognizedDescription: String { get }
    
    // MARK: - Pairing Thread error
    // MARK: - Pairing Thread error - title
    var pairingThreadErrorDatasetMissingTitle: String { get }
    var pairingThreadErrorThreadNetworkNotFoundTitle: String { get }
    var pairingErrorMobilePhoneIsNotConnectedToWifi: String { get }
    
    // MARK: - Pairing Thread error - description
    var pairingThreadErrorDatasetMissingDescription: String { get }
    func pairingThreadErrorContactSensorNoThreadNetworksFoundDescription1(zoneName: String) -> String
    var pairingThreadErrorContactSensorNoThreadNetworksFoundDescription2: String { get }
    func pairingThreadErrorNoThreadNetworksFoundDescription(zoneName: String) -> String
    var pairingErrorMobilePhoneIsNotConnectedToWifiDescription: String { get }
    
    // MARK: - Positioning error view
    var positioningErrorTitle: String { get }
    var deviceNotFoundMessage: String { get }
    var retryPositioningButton: String { get }
    var exitPositioningButton: String { get }
    
    // MARK: - URLs
    var urlNotPulsingBlue: String { get }
    var urlNamiThreadTopology: String { get }
    var urlNotConnectToThread: String { get }
    
    // MARK: - FAQ terms
    var pairingScanningBleFaq: String { get }
    var pairingScanningBleFaqDoorSensor: String { get }
}
