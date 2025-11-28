import SwiftUI
import Tomonari

// Note: HowToPosition, InitialScreen, PositioningGuidance, PositioningComplete, ErrorScreen
// types and their ViewModels are now provided by Tomonari. Do not redeclare them here
// to avoid type shadowing when StandardPairingUI is compiled against NamiPairingFramework.

@available(*, deprecated, message: "`HowToPositionView` is deprecated and replaced with empty view as a placeholder")
public struct HowToPositionView: View {
    public init(viewModel: HowToPosition.ViewModel) { }
    public var body: some View { EmptyView() }
}
@available(*, deprecated, message: "`InitialScreenView` is deprecated and replaced with empty view as a placeholder")
public struct InitialScreenView: View {
    public init(viewModel: InitialScreen.ViewModel) { }
    public var body: some View { EmptyView() }
}
@available(*, deprecated, message: "`PositioningCompleteView` is deprecated and replaced with empty view as a placeholder")
public struct PositioningCompleteView: View {
    public init(viewModel: PositioningComplete.ViewModel) { }
    public var body: some View { EmptyView() }
}
@available(*, deprecated, message: "`PositioningGuidanceView` is deprecated and replaced with empty view as a placeholder")
public struct PositioningGuidanceView: View {
    public init(viewModel: PositioningGuidance.ViewModel) { }
    public var body: some View { EmptyView() }
}
@available(*, deprecated, message: "`ErrorScreenView` is deprecated and replaced with empty view as a placeholder")
public struct ErrorScreenView: View {
    public init(viewModel: ErrorScreen.ViewModel) { }
    public var body: some View { EmptyView() }
}
