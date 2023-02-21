import CommonTypes
import SwiftUI
import Tomonari
import TokenStore
import WebAPI
import WiFiStorage

public class NamiStandardPairingSDK {
    
    public typealias APISettings = Tomonari.APISettings
    public typealias DevicePairingStatePublisher = Tomonari.DevicePairingStatePublisher
    
    private var tomonari: Tomonari
    
    /// Initializes the SDK with all the default settings.
    ///
    /// All the servcices required to communicate with nami servers are created silently.
    /// Suits the nami partners needs who doesn't use other nami libraries (WebAPI, WiFiStorage) in the other parts of the app.
    /// - Parameter access: Access Token String for the user's account.
    /// - Parameter refresh: Refresh Token String for the user's account.
    /// - Parameter apiKey: Partner's API Key for accessing nami APIs.
    public convenience init(access: TokenString, refresh: TokenString, apiKey: String) {
        self.init(access: access, refresh: refresh, apiSettings: Tomonari.APISettings.defaultWithAPIKey(apiKey))
    }
    
    /// Initializes the SDK with the API settings provided explicitly.
    ///
    /// All the servcices required to communicate with nami servers are created with base URL and sign up URL provided.
    /// Best suits initializing for testing or running with a self-hosted nami API server.
    /// - Parameter access: Access Token String for the user's account.
    /// - Parameter refresh: Refresh Token String for the user's account.
    /// - Parameter apiSettings: Settings holding API key and the urls to be called by WebAPI.
    public init(access: TokenString, refresh: TokenString, apiSettings: APISettings) {
        tomonari = Tomonari(access: access, refresh: refresh, apiSettings: apiSettings)
    }
    
    /// Initializes the SDK with the pre-existent WebAPI and WiFiStorage instances.
    ///
    /// This init is to be used in-house or by the partners who use other nami components (WebAPI, WiFiStorage) within their apps.
    /// Accepts the pre-created services to operate with.
    /// - Parameter api: Instance of WebAPI or any service complying to WebAPIProtocol.
    /// - Parameter wifiStorage: Instance of WiFiStorage or any service complying to WiFiStorageProtocol.
    public init(
        api: WebAPIProtocol,
        wifiStorage: WiFiStorageProtocol
    ) {
        tomonari = Tomonari(api: api, wifiStorage: wifiStorage)
    }
    
    public var devicePairingState: DevicePairingStatePublisher {
        tomonari.devicePairingState
    }
    
    public func startPairing(
        placeId: PlaceID,
        zoneId: PlaceZoneID,
        roomId: RoomID
    ) -> some View {
        return tomonari.startPairing(placeId: placeId, zoneId: zoneId, roomId: roomId, pairingSteps: ViewsContainer())
    }
    
    struct ViewsContainer: PairingStepsContainer {
        
        public var bluetoothUsageHint: (BluetoothUsageHint.ViewModel) -> BluetoothUsageHintView = BluetoothUsageHintView.init
        public var powerOnAndScanning: (PowerOnAndScanning.ViewModel) -> PowerOnAndScanningView = PowerOnAndScanningView.init
        public var enableBluetoothInSettings: () -> EnableBluetoothInSettingsView = EnableBluetoothInSettingsView.init
        public var bluetoothDeviceFound: (BluetoothDeviceFound.ViewModel) -> BluetoothDeviceFoundView = BluetoothDeviceFoundView.init
        public var askToConnectToWiFi: (AskToConnectToWiFi.ViewModel) -> AskToConnectToWiFiView = AskToConnectToWiFiView.init
        public var qrCodeScanner: (QRScanner.ViewModel) -> QRScannerView = QRScannerView.init
        public var listWiFiNetworks: (ListWiFiNetworks.ViewModel) -> ListWiFiNetworksView = ListWiFiNetworksView.init
        public var otherWiFiNetwork: (OtherWiFiNetwork.ViewModel) -> OtherWiFiNetworkView = OtherWiFiNetworkView.init
        public var enterWiFiPassword: (EnterWiFiPassword.ViewModel) -> EnterWiFiPasswordView = EnterWiFiPasswordView.init
        public var finishingSetup: () -> FinishingSetupView = FinishingSetupView.init
        public var pairingError: (PairingErrorScreen.ViewModel) -> PairingErrorScreenView = PairingErrorScreenView.init
        
    }
}
