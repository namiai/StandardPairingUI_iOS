// Copyright (c) nami.ai

import NamiSharedUIElements
import SwiftUI
import Tomonari

// MARK: - WiFiNetworkRowView

struct WiFiNetworkRowView: View {
    // MARK: Internal

    var network: NamiWiFiNetwork

    var body: some View {
        RoundedRectContainerView(backgroundColor: Color.white) {
            HStack {
                Image(wifiImageName())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(Color.black)
                Text(network.ssid)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                if network.open {
                    Image(systemName: "lock.open")
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(Color.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }

    // MARK: Private
    
    @EnvironmentObject private var themeManager: ThemeManager

    private func wifiImageName() -> String {
        if network.rssi >= -45 {
            return "Wifi"
        } else if network.rssi < -45, network.rssi > -85 {
            return "WifiMedium"
        } else if network.rssi <= -85 {
            return "WifiWeak"
        }

        return "Wifi"
    }
}
