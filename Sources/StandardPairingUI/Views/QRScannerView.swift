// Copyright (c) nami.ai

import BottomSheet
import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements
import CommonTypes

// MARK: - QRScannerView

public struct QRScannerView: View {
    // MARK: Lifecycle

    public init(viewModel: QRScanner.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public
    
    public var body: some View {
        DeviceSetupScreen(title: navigationBarTitle()) {
            ZStack {
                // Hack to get the available view height to calculate the bottom sheet height.
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ViewHeightKey.self, value: geometry.size.height)
                }
                
                viewModel.undecoratedScannerView
                
                VStack {
                    VStack {
                        Text(wordingManager.wordings.scanQRtitle)
                            .font(themeManager.selectedTheme.headline3)
                            .foregroundColor(themeManager.selectedTheme.primaryBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                        if viewModel.state.deviceType != .contactSensor {
                            Text(wordingManager.wordings.scanQRsubtitle)
                                .font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.bottom, .horizontal])
                        }
                        
                        if shouldShowQRcodeLocation, viewModel.state.deviceType != .unknown, let outletType = viewModel.state.outletType, outletType != .unknown {
                            DeviceQRCodeLocationImages.qrCodeLocationImage(for: viewModel.state.deviceType.qrCodeImageName(outletType: outletType))
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.bottom, .horizontal])
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(themeManager.selectedTheme.background)
                    
                    if viewModel.state.deviceType != .unknown, let outletType = viewModel.state.outletType, outletType != .unknown {
                        HStack(alignment: .center, spacing: 8) {
                            Image(shouldShowQRcodeLocation ? "Expand" : "Question", bundle: .module)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(themeManager.selectedTheme.white)
                            Text(shouldShowQRcodeLocation ? wordingManager.wordings.scanQRexpandCamera : wordingManager.wordings.scanQRwhereIsQR)
                                .font(themeManager.selectedTheme.headline5)
                                .foregroundColor(themeManager.selectedTheme.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(red: 0.2, green: 0.23, blue: 0.27).opacity(0.6))
                        .cornerRadius(100)
                        .onTapGesture {
                            shouldShowQRcodeLocation.toggle()
                        }
                    }
                    
                    GeometryReader { geometry in
                        let h = geometry.size.height
                        let w = geometry.size.width
                        let centerPoint = CGPoint(x: w / 2, y: h / 2)
                        let frameWidth = min(h, w) - 20
                        let cornerStrokeLength = frameWidth / 5
                        let cornerRadius: CGFloat = 25
                        
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                viewModel.state.error == nil ? themeManager.selectedTheme.white : themeManager.selectedTheme.negative,
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
        .onAppear {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case let h where h <= 1136: 
                    shouldShowQRcodeLocation = false
                default: 
                    shouldShowQRcodeLocation = true
                }
            }
            
            viewModel.send(event: .reset)
        }
        .onPreferenceChange(ViewHeightKey.self) { newValue in
            bottomSheetHeight = newValue * 0.44
        }
        .onChange(of: viewModel.state.error) { error in
            if error != nil {
                viewModel.send(event: .pauseScanning)
            } else {
                viewModel.send(event: .dismissScanError)
            }
        }
        .bottomSheet(item: $viewModel.state.error, height: bottomSheetHeight, content: { _ in qrErrorSheet() })
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: QRScanner.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    @State var bottomSheetHeight: CGFloat = 0
    @State var shouldShowQRcodeLocation = true

    // MARK: Private
    
    private func navigationBarTitle() -> String {
        if !wordingManager.wordings.pairingNavigationBarTitle.isEmpty { 
            return wordingManager.wordings.pairingNavigationBarTitle
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigationTitle
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
            lineWidth: 2,
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
        VStack(spacing: 0) {
            Spacer()
            Image("Warning", bundle: .module)
                .resizable()
                .frame(width: 33, height: 28)
                .scaledToFill()
            Text(wordingManager.wordings.qrCodeError)
                .font(themeManager.selectedTheme.headline4)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.top, 8)
            Text(wordingManager.wordings.qrCodeMismatchError)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.vertical, 16)
            Spacer()
            Button(wordingManager.wordings.tryAgainButton) {
                viewModel.send(event: .dismissScanError)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.bottom, 4)
            .anyView
            
            Button(wordingManager.wordings.exitSetupActionTitle) {
                viewModel.send(event: .shouldDismissItself)
            }
            .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
            .padding(.bottom, NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
            .anyView
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
