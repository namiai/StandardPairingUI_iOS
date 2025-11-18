import SwiftUI
import Tomonari

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
