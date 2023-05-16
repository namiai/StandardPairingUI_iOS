// Copyright (c) nami.ai

import Tomonari
import SwiftUI

// MARK: - QRScannerView

struct QRScannerView: View {
    // MARK: Lifecycle

    init(viewModel: QRScanner.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: QRScanner.ViewModel

    var body: some View {
        ZStack {
            viewModel.undecoratedScannerView

            Rectangle()
                .fill(Color.lowerBackground)
                .edgesIgnoringSafeArea(.all)
                .mask(cameraHoleMask())

            VStack {
                NamiChatBubble(I18n.QRScanner.whereIsQR.localized)
                    .padding(.horizontal)
                Spacer()
            }
            .padding()
        }
    }

    private func cameraHoleMask() -> some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
            Circle()
                .padding()
                .blendMode(.destinationOut)
        }
    }
}
