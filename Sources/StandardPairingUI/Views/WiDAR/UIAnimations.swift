// Copyright (c) nami.ai

import SharedAssets
import SwiftUI

public typealias Animations = SharedAssets.Animations

// MARK: - AnimationsKey

struct AnimationsKey: EnvironmentKey {
    static let defaultValue = Animations()
}

extension EnvironmentValues {
    var animations: Animations {
        get {
            self[AnimationsKey.self]
        }
        set {
            self[AnimationsKey.self] = newValue
        }
    }
}
