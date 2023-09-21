// Copyright (c) nami.ai

import CommonTypes
import Foundation
import SwiftUI

enum DeviceImages {
    static func image(for codeName: String) -> Image {
        if let deviceShape = UIImage(named: codeName.lowercased(), in: .module, with: nil) {
            return Image(uiImage: deviceShape)
        }

        return Image(uiImage: UIImage(named: "unknownmodel", in: .module, with: nil) ?? UIImage())
    }

    func image(for model: NamiDeviceModel) -> Image {
        Self.image(for: model.codeName)
    }
}
