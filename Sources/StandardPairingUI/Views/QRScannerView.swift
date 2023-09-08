// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - QRScannerView

public struct QRScannerView: View {
    // MARK: Lifecycle
    
    public init(viewModel: QRScanner.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: QRScanner.ViewModel
    
    public var body: some View {
        ZStack {
            Color.lowerBackground
                .ignoresSafeArea()
            
            viewModel.undecoratedScannerView
            
            VStack {
                VStack {
                    Text("Scan device")
                        .font(NamiTextStyle.headline3.font)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("Look for the QR code on the device. Ensure your device is not connected to power.")
                        .font(NamiTextStyle.paragraph1.font)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.bottom, .horizontal])
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity)
                .background(Color.lowerBackground)
                
                GeometryReader { geometry in
                    let h = geometry.size.height
                    let w = geometry.size.width
                    let centerPoint = CGPoint(x: w/2, y: h/2)
                    let frameWidth = min(h, w) - 20
                    let cornerStrokeLength = frameWidth / 5
                    let cornerRadius: CGFloat = 25
                    
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(
                            Color.white,
                            style: viewfinderStrokeStyle(cornerStrokeLength: cornerStrokeLength, width: frameWidth, height: frameWidth, cornerRadius: cornerRadius)
                        )
                        .position(centerPoint)
                        .frame(width: frameWidth, height: frameWidth)
                        .foregroundColor(.clear)
                    
                }
                
                .padding()
            }
        }
    }
    
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
    
}
