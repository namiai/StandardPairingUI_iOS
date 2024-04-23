// Copyright (c) nami.ai

import Lottie
import SwiftUI

public struct AnimationView: View {
    // MARK: Lifecycle

    init(animation: KeyPath<Animations, LottieAnimation>) {
        lottieAnimationPath = animation
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations
    let lottieAnimationPath: KeyPath<Animations, LottieAnimation>

    public var body: some View { animations[keyPath: lottieAnimationPath].animationView() }
}
