// Copyright (c) nami.ai

import SwiftUI

public class WordingManager: ObservableObject {
    @Published public var wordings: WordingProtocol = EmptyWordings()
    
    public init() {
        self.wordings = EmptyWordings()
    }
    
    public init(wordings: WordingProtocol) {
        self.wordings = wordings
    }
    
    public func setWordings(_ wordings: WordingProtocol) {
        self.wordings = wordings
    }
}

public class EmptyWordings: WordingProtocol {
    public init() {
        
    }
}
