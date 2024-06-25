// Copyright (c) nami.ai

import NamiSharedUIElements
import SwiftUI
import Tomonari

// MARK: - WiFiNetworkRowView

struct WiFiNetworkRowView: View {
    // MARK: Internal

    var network: NamiWiFiNetwork

    var body: some View {
        RoundedRectContainerView(backgroundColor: themeManager.selectedTheme.white) {
            HStack {
                wifiImage()
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                Text(network.ssid)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
