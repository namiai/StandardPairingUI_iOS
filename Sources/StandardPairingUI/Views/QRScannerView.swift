// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements
import CommonTypes
import SharedAssets

// MARK: - QRScannerView

public struct QRScannerView: View {
    // MARK: Lifecycle
    
    public init(viewModel: QRScanner.ViewModel) {
        self.viewModel = viewModel
        self._shouldShowError = State(initialValue: false)
        self._onDismissErrorAction = State(initialValue: nil)
    }
    
    // MARK: Public
    
    public var body: some View {
        NamiTopNavigationScreen(title: navigationBarTitle(),
                                colorOverride: themeManager.selectedTheme.navigationBarColor,
                                contentBehavior: .fixed,
                                mainContent: {
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
                            .foregroundColor(colors.textDefaultPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                        if !NamiDeviceType.allAccessoryDevices.contains(viewModel.state.deviceType) {
                            Text(wordingManager.wordings.scanQRsubtitle)
                                .font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(colors.textDefaultPrimary)
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
                    .background(colors.backgroundDefaultPrimary)
                    
                    if viewModel.state.deviceType != .unknown, let outletType = viewModel.state.outletType, outletType != .unknown {
                        HStack(alignment: .center, spacing: 8) {
                            let icon = shouldShowQRcodeLocation ? Icons.expand : Icons.question
                            icon
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.white)
                            Text(shouldShowQRcodeLocation ? wordingManager.wordings.scanQRexpandCamera : wordingManager.wordings.scanQRwhereIsQR, font: .headline5)
                                .foregroundStyle(Color.white)
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
                                // It is literally #FFFFFF in design, huh.
                                viewModel.state.error == nil ? Color.white : colors.iconDangerPrimary,
                                style: viewfinderStrokeStyle(cornerStrokeLength: cornerStrokeLength, width: frameWidth, height: frameWidth, cornerRadius: cornerRadius)
                            )
                            .position(centerPoint)
                            .frame(width: frameWidth, height: frameWidth)
                            .foregroundColor(.clear)
                    }
                    .padding()
                }
            }
        })
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
            onDismissErrorAction = { shouldShowError = false }
        }
        .onChange(of: viewModel.state.error) { error in
            if error != nil {
                viewModel.send(event: .pauseScanning)
                shouldShowError = true
            } else {
                viewModel.send(event: .dismissScanError)
                shouldShowError = false
            }
        }
        .dynamicBottomSheet(isPresented: $shouldShowError, dragIndicatorVisible: false, onDismiss: $onDismissErrorAction, content: { qrErrorSheet() })
        .ignoresSafeArea(.keyboard)
    }
    
    // MARK: Internal
    
    @ObservedObject var viewModel: QRScanner.ViewModel
    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    @Environment(\.colors) private var colors
    @State var bottomSheetHeight: CGFloat = 0
    @State var shouldShowQRcodeLocation = true
    @State var shouldShowError = false
    @State private var onDismissErrorAction: (() -> Void)?
    
    // MARK: Private
    
    private func navigationBarTitle() -> String {
        if isSettingUpKit(wordings: wordingManager.wordings) {
            return kitName(wordings: wordingManager.wordings)
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigationTitle
    }
    
    private func roundedRectPerimeter(width: CGFloat, height: CGFloat, cornerRadius radius: CGFloat) -> CGFloat {
        // Rounded rect perimeter = 2L + 2W - 8r + 2πr = 2L + 2W - (8-2)πr
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
    
    @ViewBuilder
    private func qrErrorSheet() -> some View {
        VStack(spacing: 0) {
            Spacer()
            Icons.warning
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .foregroundColor(colors.iconDangerPrimary)
            Text(wordingManager.wordings.qrCodeError)
                .font(themeManager.selectedTheme.headline4)
                .foregroundColor(colors.textDefaultPrimary)
                .padding(.top, 4)
            Text(wordingManager.wordings.qrCodeMismatchError)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(colors.textDefaultPrimary)
                .padding(.top, 16)
                .padding(.bottom, 32)
            Spacer()
            Button(wordingManager.wordings.tryAgainButton) {
                viewModel.send(event: .dismissScanError)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.bottom, NamiActionButtonStyle.ConstraintLayout.BottomToNextButton)
            .anyView
            
            Button(wordingManager.wordings.exitSetupActionTitle) {
                viewModel.send(event: .shouldDismissItself)
            }
            .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
            .padding(.bottom, NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
            .anyView
        }
        .frame(maxHeight: 330)
        .ignoresSafeArea()
        .anyView
    }
}

// MARK: - ViewHeightKey

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
