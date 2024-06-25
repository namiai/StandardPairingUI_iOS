// Copyright (c) nami.ai

import Foundation

@objc public protocol WordingProtocol {
    // MARK: - General 
    @objc optional var ok: String { get }
    @objc optional var next: String { get }
    @objc optional var cancel: String { get }
    @objc optional var pairingNavigationBarTitle: String { get }
    /// Requires string index parameter
    ///  Example: "Establishing connection with  %@…"
    @objc optional var connectingToDevice: String { get }
    
    // MARK: - Bluetooth Usage Hint View
    // Power On and Scanning View
    // Enable Bluetooth in Settings View
    @objc optional var headerConnectToPower: String { get }
    @objc optional var explainedReadyToPair: String { get }
    @objc optional var headerContactSensor: String { get }
    
    // MARK: - Power On and Scanning View
    @objc optional var scanning: String { get }
    @objc optional var askUserToWait: String { get }
    
    // MARK: - Enable Bluetooth in Settings View 
    @objc optional var bluetoothDisabled: String { get }
    @objc optional var enableBlueToothInSettingsHeader: String { get }
    @objc optional var buttonSettings: String { get }
    
    // MARK: - Enable Camera in Settings VIew 
    @objc optional var scanDeviceTitle: String { get }
    @objc optional var scanDeviceSubtitle: String { get }
    @objc optional var missingCameraPermissionTitle: String { get }
    @objc optional var missingCameraPermissionDescription: String { get }
    @objc optional var openSettings: String { get }
    
    // MARK: - Bluetooth device found View
    @objc optional var deviceFoundHeader1: String { get }
    @objc optional var deviceFoundHeader2: String { get }
    /// "{device model} text"
    @objc optional var askToNameHeader: String { get }
    @objc optional var nameDeviceExplained: String { get }
    
    // MARK: - Ask to Connect View
    @objc optional var setUpAsBorderRouter: String { get }
    @objc optional var settingUpThisDevice: String { get }
    @objc optional var nonFirstThreadDeviceDescription1: String { get }
    @objc optional var nonFirstThreadDeviceDescription2: String { get }
    @objc optional var nonFirstThreadDeviceDescription3: String { get }
    @objc optional var nonFirstWifiDeviceDescription1: String { get }
    @objc optional var wifiDeviceMetricDistanceDescription: String { get }
    @objc optional var wifiDeviceImperialDistanceDescription: String { get }
    @objc optional var firstThreadDeviceDescription1: String { get }
    @objc optional var firstThreadDeviceDescription2: String { get }
    @objc optional var firstThreadDeviceDescription3: String { get }
    @objc optional var firstWifiDeviceDescription1: String { get }
    @objc optional var firstWifiDeviceDescription2: String { get }
    
    // MARK: - QR code scanner view 
    @objc optional var scanQRtitle: String { get }
    @objc optional var scanQRsubtitle: String { get }
    @objc optional var qrCodeError: String { get }
    @objc optional var qrCodeMismatchError: String { get }
    @objc optional var tryAgainButton: String { get }
    
    // MARK: - List Wifi networks view
    @objc optional var connectWifiTitle: String { get }
    @objc optional var selectNetwork: String { get }
    @objc optional var networkNotFound: String { get }
    @objc optional var availableNetworks: String { get }
    @objc optional var otherNetworkButton: String { get }
    
    // MARK: - Enter Wifi password 
    @objc optional var enterPassword: String { get }
    @objc optional var enterPasswordHeaderTitle: String { get }
    @objc optional var passwordEntryFieldPlaceholder: String { get }
    @objc optional var passwordEntryFieldHint: String { get }
    @objc optional var buttonReadyToConnect: String { get }
    
    // MARK: - Password Retrieval alert
    @objc optional var foundSavedPassword: String { get }
    @objc optional var useSavedPassword: String { get }
    @objc optional var forget: String { get }
    
    // MARK: - Other wifi network view 
    @objc optional var otherWifiNetworkTitle: String { get }
    @objc optional var deviceConnectivityHint: String { get }
    @objc optional var networkNamePlaceholder: String { get }
    @objc optional var passwordPlaceholder: String { get }
    @objc optional var readyToConnectButton: String { get }
    
    // MARK: - Finishing setup
    @objc optional var finishingSetupHeader: String { get }
    @objc optional var gameOfPongText: String { get }
    
    // MARK: - Positioning general
    @objc optional var positioningNavigationTitle: String { get }
    
    // MARK: - Initial positioning screen
    @objc optional var widarInfoTitle: String { get }
    @objc optional var widarInfoMustOptimisePosition: String { get }
    @objc optional var widarInfoAvoidMovingWhenOptimized: String { get }
    @objc optional var nextButton: String { get }
    
    // MARK: - How to position view
    @objc optional var startPositioningButton: String { get }
    @objc optional var recommendationsTitle: String { get }
    @objc optional var recommendationsInfoAttachBase: String { get }
    @objc optional var recommendationsInfoWireOnBack: String { get }
    @objc optional var recommendationsInfoKeepAreaClear: String { get }
    
    // MARK: - Positioning guidance view
    @objc optional var finishButton: String { get }
    @objc optional var cancelButton: String { get }
    @objc optional var positioningGuidanceTitle: String { get }
    @objc optional var guideMetric: String { get }
    @objc optional var guideImperial: String { get }
    @objc optional var statusLabel: String { get }
    @objc optional var statusChecking: String { get }
    @objc optional var statusMispositioned: String { get }
    @objc optional var statusGettingBetter: String { get }
    @objc optional var statusOptimized: String { get }
    @objc optional var statusEstablishingConnection: String { get }
    @objc optional var positioningTip: String { get }
    
    // MARK: - Positioning guidance: cancel positioning popup 
    @objc optional var cancelPopupTitle: String { get }
    @objc optional var cancelPopupMessage: String { get }
    @objc optional var cancelPopupBackToPositioningButton: String { get }
    @objc optional var cancelPopupCancelButton: String { get }
    
    // MARK: - Positioning complete view
    @objc optional var successTitle: String { get }
    @objc optional var sucessContentMessage: String { get }
    @objc optional var doneButton: String { get }
    
    // Error screens
    
    // MARK: - Pairing error view
    @objc optional var errorOccurredTitle: String { get }
    @objc optional var tryAgainActionTitle: String { get }
    @objc optional var restartActionTitle: String { get }
    @objc optional var ignoreActionTitle: String { get }
    
    
    // MARK: - Positioning error view
    @objc optional var positioningErrorTitle: String { get }
    @objc optional var deviceNotFoundMessage: String { get }
    @objc optional var retryPositioningButton: String { get }
    @objc optional var exitPositioningButton: String { get }
}
