# StandardPairingUI

The packege provides the application code with the standard pairing UI and imports internally [Tomonari](https://github.com/namiai/Tomonari) (the library for pairing nami devices).

## Use the package
It's as easy as initializing `ViewsContainer()` which implements `Tomonari` `PairingStepsContainer` protocol. Then an instance of `ViewsContainer` should be passed to `Tomonari` `public func startPairing<Container: PairingStepsContainer>(placeId: PlaceID, zoneId: PlaceZoneID, roomId: RoomID, updateWiFiCredentialsSessionId: WiFiCredentialsUpdateSessionID? = nil, pairingSteps: Container)` to get the `View`, holding the pairing steps UI and perform the pairing. 
