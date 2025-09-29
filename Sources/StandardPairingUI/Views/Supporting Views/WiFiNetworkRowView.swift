// Copyright (c) nami.ai

import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

// MARK: - WiFiNetworkRowView

struct WiFiNetworkRowView: View {
    // MARK: Internal

    @Environment(\.colors) var colors: Colors

    var network: NamiWiFiNetwork

    var body: some View {
        HStack {
            wifiImage()
                .foregroundColor(colors.iconDefaultPrimary)
            Text(network.ssid)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(colors.textDefaultPrimary)
                .lineLimit(1)
                .truncationMode(.tail)
            if network.open {
                Image(systemName: "lock.open")
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(colors.iconDefaultPrimary)
            }
            Spacer()
        }
        .background(colors.backgroundDefaultSecondary)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    // MARK: Private

    @Environment(\.themeManager) private var themeManager

    private func wifiImage() -> some View {
        if network.rssi >= -45 {
            return Icons.wifi
        } else if network.rssi < -45, network.rssi > -85 {
            return Icons.wifimedium
        } else if network.rssi <= -85 {
            return Icons.wifiweak
        }
        return Icons.wifi
    }

    private func imageExists(_ name: String) -> Bool {
        guard let _ = UIImage(named: name) else {
            return false
        }
        return true
    }
}
