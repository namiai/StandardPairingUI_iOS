// Copyright (c) nami.ai

import I18n
import Foundation
import NamiProto
import Tomonari

extension Pairing_Error {
    var localizedDescription: String {
        switch error {
        case .secureSessionError:
            return I18n.Errors.PairingErrorDevice.secureSession.localized
        case .cloudChallengeError:
            return I18n.Errors.PairingErrorDevice.cloudChallenge.localized
        case .wifiScanError:
            return I18n.Errors.PairingErrorDevice.wifiScan.localized
        case .wifiJoinError:
            return I18n.Errors.PairingErrorDevice.wifiJoin.localized
        case .wifiJoinPasswordError:
            return I18n.Errors.PairingErrorDevice.wifiJoinPassword.localized
        case .wifiJoinIpError:
            return I18n.Errors.PairingErrorDevice.wifiJoinIP.localized
        default:
            return I18n.Errors.PairingErrorDevice.unknown.localized
        }
    }
}

public extension Pairing.Error {
    var localizedDescription: String {
        switch self {
        case let .underlying(error):
            if let error = error as? PairingMachineError {
                return error.localizedDescription
            }
            if let error = error as? PairingNetworkError {
                return error.localizedDescription
            }
            if let error = error as? Pairing.ThreadError {
                return error.localizedDescription
            }
            return error.localizedDescription
        }
    }
}

extension PairingMachineError {
    var localizedDescription: String {
        switch self {
        case .unexpectedState:
            return I18n.Errors.PairingMachine.unexpectedState.localized
        case .unexpectedMessage:
            return I18n.Errors.PairingMachine.unexpectedMessage.localized
        case .seanceError:
            return I18n.Errors.PairingMachine.seance.localized
        case let .pairingError(pairingError):
            return pairingError.localizedDescription
        case .serializationError:
            return I18n.Errors.PairingMachine.serialization.localized
        case .deserializationError:
            return I18n.Errors.PairingMachine.deserialization.localized
        case .encryptionError:
            return I18n.Errors.PairingMachine.encryption.localized
        }
    }
}

extension Pairing.ThreadError {
    var localizedDescription: String {
        // TODO: Add errors from I18n.
        switch self {
        case .threadOperationalDatasetMissing:
            return I18n.Errors.PairingThreadSetupError.threadOperationalDatasetMissing.localized
        case .threadNetworkNotFound:
            return I18n.Errors.PairingThreadSetupError.threadNetworkNotFound.localized
        case .mixedEnvironment:
            return I18n.Errors.PairingThreadSetupError.mixedEnvironment.localized
        }
    }
}
