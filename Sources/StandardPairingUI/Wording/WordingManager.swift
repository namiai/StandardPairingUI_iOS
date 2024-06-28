// Copyright (c) nami.ai

import SwiftUI

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
}

private struct DefaultWordings: WordingProtocol {
    public init() {
        
    }
}
