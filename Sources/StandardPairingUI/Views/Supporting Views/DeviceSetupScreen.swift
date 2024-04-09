// Copyright (c) nami.ai

import I18n
import SwiftUI
import SharedAssets

// MARK: - DeviceSetupScreen

public struct DeviceSetupScreen<Subview: View>: View {
    // MARK: Lifecycle

//    @Environment(\.colors) var colors: Colors
    
    public init(@ViewBuilder subview: @escaping () -> Subview) {
        self.subview = subview
    }

    // MARK: Public

    public var body: some View {
        ZStack {
            Color.namiColors.lowerBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                subview()
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text(I18n.Pairing.DeviceSetup.navigagtionTitle)
        )
    }

    // MARK: Private

    private let subview: () -> Subview
}

// MARK: - DeviceSetupScreen_Previews

struct DeviceSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSetupScreen {
            Text("So removed, we spoke of wintertime in France")
            Button("Ride on the metro") {
                print("I was on a Paris train, I emerged in London rain")
            }
        }
    }
}
