// Copyright (c) nami.ai

import Foundation
import I18n
import NamiProto
import Tomonari

extension Pairing_Error {
    var localizedDescription: String {
        switch error {
        case .secureSessionError:
            return I18n.Errors.PairingErrorDevice.secureSessionError
        case .cloudChallengeError:
            return I18n.Errors.PairingErrorDevice.cloudChallengeError
        case .wifiScanError:
            return I18n.Errors.PairingErrorDevice.wifiScanError
        case .wifiJoinError:
            return I18n.Errors.PairingErrorDevice.wifiJoinError
        case .wifiJoinPasswordError:
            return I18n.Errors.PairingErrorDevice.wifiJoinPasswordError
        case .wifiJoinIpError:
            return I18n.Errors.PairingErrorDevice.wifiJoinIpError
        default:
            return I18n.Errors.PairingErrorDevice.unknownUnrecognized
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
            return I18n.Errors.PairingMachine.unexpectedState
        case .unexpectedMessage:
            return I18n.Errors.PairingMachine.unexpectedMessage
        case .seanceError:
            return I18n.Errors.PairingMachine.seanceError
        case let .pairingError(pairingError):
            return pairingError.localizedDescription
        case .serializationError:
            return I18n.Errors.PairingMachine.serializationError
        case .deserializationError:
            return I18n.Errors.PairingMachine.deserializationError
        case .encryptionError:
            return I18n.Errors.PairingMachine.encryptionError
        }
    }
}

extension Pairing.ThreadError {
    var localizedDescription: String {
        // TODO: Add errors from I18n.
        switch self {
        case .threadOperationalDatasetMissing:
            return I18n.Errors.PairingThreadSetupError.threadOperationalDatasetMissing
        case .threadNetworkNotFound:
            return I18n.Errors.PairingThreadSetupError.threadNetworkNotFound
        case .mixedEnvironment:
            return I18n.Errors.PairingThreadSetupError.mixedEnvironment
        }
    }
}
