// Copyright (c) nami.ai

func isSettingUpKit(wordings: WordingProtocol) -> Bool {
    return !wordings.pairingNavigationBarTitle.isEmpty
}

func kitName(wordings: WordingProtocol) -> String {
    return wordings.pairingNavigationBarTitle
}
