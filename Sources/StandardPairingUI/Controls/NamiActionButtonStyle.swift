// Copyright (c) nami.ai

import SwiftUI
import SharedAssets
import NamiSharedUIElements

// MARK: - NamiActionButtonStyle

public struct NamiActionButtonStyle: ButtonStyle {
    // MARK: Lifecycle

    public init(
        rank: AppearanceHierarchyRank = .primary,
        sharpCorner: UIRectCorner = .topRight
    ) {
        self.rank = rank
        self.sharpCorner = sharpCorner
    }

    // MARK: Internal

    public struct NamiActionButton: View {
        let configuration: ButtonStyle.Configuration
        let rank: AppearanceHierarchyRank
        let excCorner: UIRectCorner
        @Environment(\.colors) var colors: Colors
        @Environment(\.isEnabled) var isEnabled: Bool

        public var body: some View {
            RoundedRectContainerView(
                excludingCorners: excCorner,
                strokeWidth: rank.strokeWidth,
                strokeColor: rank.strokeColor,
                backgroundColor: isEnabled
                    ? rank.foregroundColor
                    : rank.disabledForegroundColor
            ) {
                configuration.label
                    .foregroundColor(isEnabled ? rank.textColor : rank.disabledTextColor)
                    .font(NamiTextStyle.headline5.font)
                    .padding([.leading, .trailing], 24)
                    .padding([.top, .bottom], 16)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .padding([.leading, .trailing], ConstraintLayout.LeadingToSuperView)    // In this case, the leading and trailing paddings are the same, so we can choose one of them as well.
        }
    }

    public enum AppearanceHierarchyRank {
        case primary
        case secondary
        case tertiary
        case destructive

        // MARK: Internal

        var foregroundColor: Color {
            switch self {
            case .primary:
                return Color.namiColors.primary
            case .secondary:
                return Color.namiColors.neutral.white
            case .tertiary:
                return .clear
            case .destructive:
                return Color.namiColors.neutral.white
            }
        }

        var textColor: Color {
            switch self {
            case .primary:
                return Color.namiColors.neutral.white
            case .secondary:
                return Color.namiColors.primary
            case .tertiary:
                return Color.namiColors.primary
            case .destructive:
                return Color.namiColors.negative
            }
        }

        var strokeColor: Color {
            switch self {
            case .secondary:
                return .black
            default:
                return .clear
            }
        }

        var strokeWidth: CGFloat? {
            switch self {
            case .secondary:
                return 1
            default:
                return nil
            }
        }

        var disabledForegroundColor: Color {
            foregroundColor // .opacity(0.4)
        }

        var disabledTextColor: Color {
            textColor.opacity(0.4)
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        NamiActionButton(configuration: configuration, rank: rank, excCorner: sharpCorner)
    }
    
    // MARK: - the padding for NamiActionButtonStyle as a constant
    public struct ConstraintLayout {
        // Padding for this self
        public static let LeadingToSuperView: CGFloat = 16
        public static let TrailingToSuperView: CGFloat = 16
        public static let BottomToSuperView: CGFloat = 32
        public static let BottomToNextButton: CGFloat = 8
        public static let BottomTokeyboard: CGFloat = 16
    }

    // MARK: Private

    private var rank: AppearanceHierarchyRank
    private var sharpCorner: UIRectCorner
}

// MARK: - NamiActionButtonStyle_Previews

struct NamiActionButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()

            VStack {
                Button("Example button", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle())
                Button("Disabled primary", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle())
                    .disabled(true)
                Button("Example secondary button", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle(rank: .secondary))
                Button("Disabled secondary", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle(rank: .secondary))
                    .disabled(true)
                Button("Example tertiary button", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle(rank: .tertiary))
                Button("Disabled tertiary", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle(rank: .tertiary))
                    .disabled(true)
                Button("Example destructive button", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle(rank: .destructive))
                Button("Disabled destructive", action: { print("Click-Clack") })
                    .buttonStyle(NamiActionButtonStyle(rank: .destructive))
                    .disabled(true)
            }
            .padding()
        }
    }
}
