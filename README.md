# NamiStandardPairingSDK

The packege provides the application code with the standard pairing UI and imports internally [Tomonari](https://github.com/namiai/Tomonari) (the library for pairing nami devices).
Few methods are exposed to the consumers: a bunch of ways to initialize the SDK and `func startPairing(placeId: PlaceID, zoneId: PlaceZoneID, roomId: RoomID) -> some View`. Initialized SDK instance could be reused across the consumer's app and returns the fully set up view where the pairing process with the default UI would be presented.

## Prerequisites
An application consuming the SDK should 
- Have the way to sign up / sign in nami system. 
- Be provided with the registered partner's API key.

During the sign up / sign in the app is responded with the user data including (but not limited to) the pair of tokens: access token and refresh token. The tokens are provide the user authentication.
All the communication to the API also should be authenticated with the API Key set for `x-api-key` header. 

__NOTE__: The partners API Keys creation / expiration / revokation is not yet discussed yet at the moment of writing. 

## Use SDK
When the prerequisites are met `NamiStandardPairingSDK` instance might be initialized in a few ways:

- `init(access: TokenString, refresh: TokenString, apiKey: String)` initializes the SDK with all the default settings.
All the servcices required to communicate with nami servers are created silently.
Suits the needs of nami partners who doesn't use other nami libraries (WebAPI, WiFiStorage) in the other parts of the app.
    
- `init(access: TokenString, refresh: TokenString, apiSettings: APISettings)` initializes the SDK with the API settings provided explicitly.
All the servcices required to communicate with nami servers are created with base URL and sign up URL provided in `APISettings` structure.
Best suits initializing for testing or running with a self-hosted nami API server.
    
- `init(api: WebAPIProtocol, wifiStorage: WiFiStorageProtocol)` initializes the SDK with the pre-existent WebAPI and WiFiStorage instances.
This init is to be used in-house or by the partners who use other nami components (WebAPI, WiFiStorage) within their apps.
Accepts the pre-created services to operate with.

On an instance of `NamiStandardPairingSDK` then to be called `func startPairing(placeId: PlaceID, zoneId: PlaceZoneID, roomId: RoomID) -> some View`. It returns a `View` in which all the pairing steps would be presented.

The device pairing states might be observed through `var devicePairingState: DevicePairingStatePublisher`. It does not publish every pairing step but rather exposes the crucial states when the consuming app might need to react accordingly. States are following:

- `deviceCommisionedAtCloud(Device, in: PlaceID)`: A record for the newly commisioned device is created in the cloud (but device is not yet fully set up). At this step the SDK consumer might want to store the record locally or keep it until the device is fully set up.

- `deviceOperable(DeviceID)`: Device is fully set up: it confirms that it could connect to wi-fi network with the password provided.

- `deviceDecommissioned(DeviceID)`: In case of a failute or the pairing cancellation after the successful commissioning to the cloud (see `deviceCommisionedAtCloud`) the device record is removed from the cloud. The SDK consumer might want to remove (or discard if not stored locally) the record for the device obtained on `deviceCommisionedAtCloud`. 
        
- `pairingCancelled`: Indicates the abortion of the pairing process when no additional cleanup might be required in consumer's code. E.g. if the pairing cancellation is confirmed and the pairing was stopped at the stage when no additional Device data were yet returned from the cloud.
        
## Example
The following code is used internally in nami app to manage the pairing process with the SDK:

```Swift
// Copyright (c) nami.ai

import Combine
import CommonTypes
import Foundation
import LocalStorage
import Log
import NamiStandardPairingSDK
import SwiftUI
import WebAPI
import WiFiStorage

final class PairingManager {
    // MARK: Lifecycle

    init(
        api: WebAPIProtocol,
        storage: LocalStorageProtocol,
        wifiStorage: WiFiStorageProtocol
    ) {
        pairingSdk = NamiStandardPairingSDK(api: api, wifiStorage: wifiStorage)

        setupSubscription(api: api, storage: storage, wifiStorage: wifiStorage)
    }

    // MARK: Internal

    func startPairing(
        placeId: PlaceID,
        zoneId: PlaceZoneID,
        roomId: RoomID,
        onPairingComplete: (() -> Void)? = nil
    ) -> some View {
        self.onPairingComplete = onPairingComplete
        return pairingSdk.startPairing(placeId: placeId, zoneId: zoneId, roomId: roomId)
    }

    // MARK: Private

    private var pairingSdk: NamiStandardPairingSDK
    private var subscriptions = Set<AnyCancellable>()
    private var onPairingComplete: (() -> Void)?

    private func setupSubscription(
        api: WebAPIProtocol,
        storage: LocalStorageProtocol,
        wifiStorage: WiFiStorageProtocol
    ) {
        pairingSdk.devicePairingState
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    Log.warning("[PairingManager] Device state publisher failed with error: \(error.localizedDescription)")
                }
                guard let self else { return }
                self.completePairing()
                self.pairingSdk = NamiStandardPairingSDK(api: api, wifiStorage: wifiStorage)
                self.setupSubscription(api: api, storage: storage, wifiStorage: wifiStorage)
            } receiveValue: { [weak self] deviceState in
                switch deviceState {
                case let .deviceCommisionedAtCloud(device, in: placeId):
                    try? storage.updateDevice(device, placeId: placeId)
                case .deviceOperable:
                    self?.completePairing()
                case let .deviceDecommissioned(deviceId):
                    _ = storage.deleteDeviceSkippingAPICall(id: deviceId)
                    self?.completePairing()
                case .pairingCancelled:
                    self?.completePairing()
                }
            }
            .store(in: &subscriptions)
    }

    private func completePairing() {
        onPairingComplete?()
        onPairingComplete = nil
    }
}

```
