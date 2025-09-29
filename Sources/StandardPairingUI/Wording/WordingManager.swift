// Copyright (c) nami.ai

import I18n
import SwiftUI

// MARK: - WordingManager

public class WordingManager: ObservableObject {
    // MARK: Lifecycle

    public init() {
        wordings = DefaultWordings()
    }

    public init(wordings: WordingProtocol) {
        self.wordings = wordings
    }

    // MARK: Public

    @Published public var wordings: WordingProtocol

    public func setWordings(_ wordings: WordingProtocol) {
        self.wordings = wordings
    }

    public func resetWordings() {
        wordings = DefaultWordings()
    }

    public func updateKitNameTitle(to newTitle: String) {
        wordings.kitNameNavigationBarTitle = newTitle
    }
}

// MARK: - WordingManagerKey

private struct WordingManagerKey: EnvironmentKey {
    static let defaultValue = WordingManager()
}

public extension EnvironmentValues {
    var wordingManager: WordingManager {
        get { self[WordingManagerKey.self] }
        set { self[WordingManagerKey.self] = newValue }
    }
}

// MARK: - DefaultWordings

private struct DefaultWordings: WordingProtocol {
    // MARK: Lifecycle

    init() {}

    // MARK: Internal

    var kitNameNavigationBarTitle = ""
}
