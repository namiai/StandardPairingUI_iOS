//
//  KitSetup.swift
//  StandardPairingUI
//
//  Created by Gleb Vodovozov on 10/2/25.
//

func isSettingUpKit(wordings: WordingProtocol) -> Bool {
    return wordings.pairingNavigationBarTitle.isEmpty
}

func kitName(wordings: WordingProtocol) -> String {
    return wordings.pairingNavigationBarTitle
}
