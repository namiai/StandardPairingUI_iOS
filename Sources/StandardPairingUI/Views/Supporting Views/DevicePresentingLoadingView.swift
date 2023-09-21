
import SwiftUI
import CommonTypes
import I18n

struct DevicePresentingLoadingView: View {
    
    init(deviceName: String, deviceModel: NamiDeviceModel) {
        self.deviceName = deviceName
        self.deviceModel = deviceModel
    }
    
    private var deviceName: String
    private var deviceModel: NamiDeviceModel
    
    
    var body: some View {
        VStack {
            
            Spacer()
            DeviceImages.image(for: deviceModel.codeName)
                .resizable()
                .scaledToFit()
                .padding()
            
            Text(I18n.Pairing.LoadingDevice.connecting.localized(with: deviceName))
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            
            ProgressView()
            Spacer()
        }
        
    }
}

struct DevicePresentingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DevicePresentingLoadingView(deviceName: "Plug in the living room", deviceModel: .unknown)
    }
}
