# StandardPairingUI

## To build the project 
Please put `NamiPairingFramework.xcframework` file on the path where this package code is contained (in the same directory where this package directory is) or edit `Package.swift` to point `.binaryTarget(name: "NamiPairingFramework", path: "../NamiPairingFramework.xcframework")` to the framework file.

```
..
├── StandardPairingUI_iOS
│   ├── Package.swift
│   ├── README.md
│   └── Sources
└── NamiPairingFramework.xcframework
```

## Use the package
It's as easy as initializing `ViewsContainer()` which implements `NamiPairingFramework` `PairingStepsContainer` protocol. Then an instance of `ViewsContainer` should be passed to `NamiPairingFramework` `public func startPairing<Container: PairingStepsContainer>(placeId: PlaceID, zoneId: PlaceZoneID, roomId: RoomID, updateWiFiCredentialsSessionId: WiFiCredentialsUpdateSessionID? = nil, pairingSteps: Container)` to get the `View`, holding the pairing steps UI and perform the pairing. 
