// Copyright (c) nami.ai

import BottomSheet
import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements

// MARK: - QRScannerView

public struct QRScannerView: View {
    // MARK: Lifecycle

    public init(viewModel: QRScanner.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        ZStack {
            Color.namiColors.lowerBackground
                .ignoresSafeArea()

            // Hack to get the available view height to calculate the bottom sheet height.
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ViewHeightKey.self, value: geometry.size.height)
            }

            viewModel.undecoratedScannerView

            VStack {
                VStack {
                    Text(I18n.Pairing.ScanQr.title)
                        .font(NamiTextStyle.headline3.font)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .top])
                    Text(I18n.Pairing.ScanQr.subtitle)
                        .font(NamiTextStyle.paragraph1.font)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.bottom, .horizontal])
                }
                .frame(maxWidth: .infinity)
                .background(Color.namiColors.lowerBackground)

                GeometryReader { geometry in
                    let h = geometry.size.height
                    let w = geometry.size.width
                    let centerPoint = CGPoint(x: w / 2, y: h / 2)
                    let frameWidth = min(h, w) - 20
                    let cornerStrokeLength = frameWidth / 5
                    let cornerRadius: CGFloat = 25

                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(
                            viewModel.state.error == nil ? Color.white : Color.namiColors.negative,
                            style: viewfinderStrokeStyle(cornerStrokeLength: cornerStrokeLength, width: frameWidth, height: frameWidth, cornerRadius: cornerRadius)
                        )
                        .position(centerPoint)
                        .frame(width: frameWidth, height: frameWidth)
                        .foregroundColor(.clear)
                }
                .padding()
            }
        }
        .navigationBarHidden(false)
        .navigationTitle(
            Text(I18n.Pairing.DeviceSetup.navigagtionTitle)
        )
        .onPreferenceChange(ViewHeightKey.self) { newValue in
            bottomSheetHeight = newValue * 0.5
        }
        .onChange(of: viewModel.state.error) { error in
            if error != nil {
                viewModel.send(event: .pauseScanning)
            } else {
                viewModel.send(event: .dismissScanError)
            }
        }
        .bottomSheet(item: $viewModel.state.error, height: bottomSheetHeight, content: { _ in qrErrorSheet() })
    }

    // MARK: Internal

    @ObservedObject var viewModel: QRScanner.ViewModel
    @State var bottomSheetHeight: CGFloat = 0

    // MARK: Private

    private func roundedRectPerimeter(width: CGFloat, height: CGFloat, cornerRadius radius: CGFloat) -> CGFloat {
        // Rounded rect perimeter = 2L + 2W - 8r + 2πr = 2L + 2W - (8-2π)r
        (2 * width) + (2 * height) - ((8 - 2 * CGFloat.pi) * radius)
    }

    private func viewfinderStrokeStyle(cornerStrokeLength: CGFloat, width: CGFloat, height: CGFloat, cornerRadius radius: CGFloat) -> StrokeStyle {
        let fourCornersLen = cornerStrokeLength * 4
        let viewfinderPerimeter = roundedRectPerimeter(width: width, height: height, cornerRadius: radius)
        // Gap between strokes corrected to perimeter of rounded rect
        let segmentGap = (viewfinderPerimeter - fourCornersLen) / 4
        // Shift strokes start position with `dashPhase`
        let phaseCorrection = (viewfinderPerimeter / 8) + (cornerStrokeLength / 2)
        return StrokeStyle(
            lineWidth: 5,
            lineCap: .round,
            lineJoin: .round,
            miterLimit: .infinity,
            dash: [
                cornerStrokeLength,
                segmentGap,
            ],
            dashPhase: phaseCorrection
        )
    }

    private func qrErrorSheet() -> some View {
        VStack {
            HStack {
                Image("Warning")
                    .frame(width: 32)
                Text(I18n.UpdateWifi.qrCodeError)
                    .font(NamiTextStyle.headline4.font)
            }
            Text(I18n.UpdateWifi.notNamiQrCodeNoZone)
                .font(NamiTextStyle.paragraph1.font)
            Button(I18n.Pairing.Errors.actionTryAgain) {
                viewModel.send(event: .dismissScanError)
            }
            .buttonStyle(NamiActionButtonStyle())
        }
        .ignoresSafeArea()
    }
}

// MARK: - ViewHeightKey

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
