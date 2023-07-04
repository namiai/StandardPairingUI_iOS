# StandardPairingUI

## Use the package
It's as easy as initializing `ViewsContainer()` which implements `NamiPairingFramework` `PairingStepsContainer` protocol. Then an instance of `ViewsContainer` should be passed to `NamiPairingFramework` `public func startPairing<Container: PairingStepsContainer>(placeId: PlaceID, zoneId: PlaceZoneID, roomId: RoomID, updateWiFiCredentialsSessionId: WiFiCredentialsUpdateSessionID? = nil, pairingSteps: Container)` to get the `View`, holding the pairing steps UI and perform the pairing. 
