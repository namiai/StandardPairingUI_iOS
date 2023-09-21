
import SwiftUI
import I18n

public struct DeviceSetupScreen<Subview: View>: View {
    
    public init(@ViewBuilder subview: @escaping () -> Subview) {
        self.subview = subview
    }
    
    private let subview: () -> Subview
    
    public var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                subview()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text(I18n.Pairing.DeviceSetup.navigagtionTitle.localized)
        )
    }
}

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

