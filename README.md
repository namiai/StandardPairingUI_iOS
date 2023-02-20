# NamiStandardPairingSDK

The packege provides the application code with the standard pairing UI and imports internally [Tomonari](https://github.com/namiai/Tomonari) (the library for pairing nami devices).
Two methods are exposed to the consumers: `init(api: WebAPIProtocol, wifiStorage: WiFiStorageProtocol)` and `func startPairing(placeId: PlaceID, zoneId: PlaceZoneID, roomId: RoomID) -> some View`. Initialized SDK instance could be reused across the consumer's app and returns the fully set up view where the pairing process with the default UI would be presented.
