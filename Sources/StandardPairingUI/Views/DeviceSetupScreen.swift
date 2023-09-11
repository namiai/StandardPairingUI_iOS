
import SwiftUI
import I18n

struct DeviceSetupScreen<Subview: View>: View {
    
    init(@ViewBuilder subview: @escaping () -> Subview) {
        self.subview = subview
    }
    
    private let subview: () -> Subview
    
    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                subview()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text("Device setup")
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

