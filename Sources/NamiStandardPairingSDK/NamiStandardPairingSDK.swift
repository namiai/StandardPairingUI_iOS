import CommonTypes
import SwiftUI
import Tomonari
import WebAPI
import WiFiStorage

public class NamiStandardPairingSDK {
    
    private var tomonari: Tomonari
    
    public init(
        api: WebAPIProtocol,
        wifiStorage: WiFiStorageProtocol
    ) {
        tomonari = Tomonari(api: api, wifiStorage: wifiStorage)
    }
    
    public var devicePairingState: Tomonari.DevicePairingStatePublisher {
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
