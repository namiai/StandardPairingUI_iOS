// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle
    
    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    
    public var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Connect device to power outlet")
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("The LED will pulse dark blue to let you know that the device is ready to pair")
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("Searching for device")
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                Text("Please hold...")
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .padding(.top, 4)
                if viewModel.state.showsProgressIndicator {
                    ProgressView()
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text("Device setup")
        )
    }
}
