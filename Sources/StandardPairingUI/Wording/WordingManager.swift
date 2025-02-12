// Copyright (c) nami.ai

import SwiftUI
import I18n

public class WordingManager: ObservableObject {
    @Published public var wordings: WordingProtocol
    
    public init() {
        self.wordings = DefaultWordings()
    }
    
    public init(wordings: WordingProtocol) {
        self.wordings = wordings
    }
    
    public func setWordings(_ wordings: WordingProtocol) {
        self.wordings = wordings
    }
    
    public func resetWordings() {
        self.wordings = DefaultWordings()
    }
    
    public func updatePairingTitle(to newTitle: String) {
        self.wordings.pairingNavigationBarTitle = newTitle
    }
}

private struct WordingManagerKey: EnvironmentKey {
    static let defaultValue: WordingManager = WordingManager()
}

public extension EnvironmentValues {
    var wordingManager: WordingManager {
        get { self[WordingManagerKey.self] }
        set { self[WordingManagerKey.self] = newValue }
    }
}

private struct DefaultWordings: WordingProtocol {
    var pairingNavigationBarTitle: String = I18n.pairingDeviceSetupNavigagtionTitle
    
    public init() {
        
    }
}
