// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - BluetoothUsageHintView

public struct BluetoothUsageHintView: View {
    // MARK: Lifecycle
    
    public init(viewModel: BluetoothUsageHint.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: BluetoothUsageHint.ViewModel
    
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
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text("Device setup")
        )
        .onAppear {
            viewModel.send(event: .tapNext)
        }
    }
}
