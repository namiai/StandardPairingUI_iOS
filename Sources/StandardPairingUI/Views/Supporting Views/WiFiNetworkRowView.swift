// Copyright (c) nami.ai

import NamiSharedUIElements
import SwiftUI
import Tomonari
import SharedAssets

// MARK: - WiFiNetworkRowView

struct WiFiNetworkRowView: View {
    @Environment(\.colors) var colors: Colors
    // MARK: Internal

    var network: NamiWiFiNetwork

    var body: some View {
        RoundedRectContainerView(backgroundColor: colors.backgroundDefaultPrimary) {
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
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }

    // MARK: Private
    
    @Environment(\.themeManager) private var themeManager

    private func wifiImage() -> some View {
        if network.rssi >= -45 {
            return imageExists("Wifi") ? Image("Wifi") : Image(systemName: "wifi")
        } else if network.rssi < -45, network.rssi > -85 {
            if #available(iOS 16.0, *) {
                return imageExists("WifiMedium") ? Image("WifiMedium") : Image(systemName: "wifi", variableValue: 0.4)
            } else {
                return imageExists("WifiMedium") ? Image("WifiMedium") : Image(systemName: "wifi")
            }
        } else if network.rssi <= -85 {
            if #available(iOS 16.0, *) {
                return imageExists("WifiWeak") ? Image("WifiWeak") : Image(systemName: "wifi", variableValue: 0.2)
            } else {
                return imageExists("WifiWeak") ? Image("WifiWeak") : Image(systemName: "wifi")
            }
        }
        return Image(systemName: "wifi")
    }
    
    private func imageExists(_ name: String) -> Bool {
        guard let _ = UIImage(named: name) else {
            return false
        }
        return true
    }
}
