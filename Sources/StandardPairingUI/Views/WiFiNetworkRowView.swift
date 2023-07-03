// Copyright (c) nami.ai

import SwiftUI
import Tomonari
import NamiTextStyle

// MARK: - WiFiNetworkRowView

struct WiFiNetworkRowView: View {
    // MARK: Internal

    var network: NamiWiFiNetwork
    var selected: Bool

    var body: some View {
        RoundedRectContainerView(backgroundColor: Color.white) {
            HStack {
                Image(wifiImageName())
                    .foregroundColor(Color.black)
                Text(network.ssid)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                if network.open {
                    Image(systemName: "lock.open")
                        .foregroundColor(Color.black)
                }
                Spacer()
                if selected {
                    Image("Checkmark")
                }
            }
            .padding()
        }
    }

    // MARK: Private

    private func wifiImageName() -> String {
        if network.rssi >= -45 {
            return "Wifi"
        } else if network.rssi < -45 && network.rssi > -85 {
            return "WifiMedium"
        } else if network.rssi <= -85 {
            return "WifiWeak"
        }

        return "Wifi"
    }
}
