// Copyright (c) nami.ai

import Foundation
import I18n
import NamiProto
import Tomonari

// Upper level of matryoshka.
public extension Pairing.Error {
    var errorMessageTitle: String {
        if case let .underlying(error) = self {
            if let error = error as? PairingMachineError, case let .pairingError(e) = error {
                switch e.error {
                case .wifiScanError:
                    return "The device could not find any available Wi-Fi networks"
                case .wifiJoinError:
                    return "The device could not join the select Wi-Fi network"
                case .wifiJoinPasswordError:
                    return "The password for the selected Wi-Fi network was rejected by the router"
                default:
                    break
                }
            }
            if let error = error as? Pairing.ThreadError {
                switch error {
                case .threadOperationalDatasetMissing:
                    return "Thread network credentials are not found as user is using a different mobile device"
                case .threadNetworkNotFound:
                    return "Device is unable to find the selected Thread network or is too far from the Thread network"
                case .mixedEnvironment:
                    return "User is trying to set up a Thread device in a zone with non-Thread devices OR vice versa"
                }
            }
        }
        return I18n.Pairing.Errors.errorOccurredTitle
    }

    var localizedDescription: String {
        switch self {
        case let .underlying(error):
            if let error = error as? PairingMachineError {
                // This one has the lower layers. See below.
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
        case let .pairingError(pairingError): // Pairing_Error.
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

// Inner level of PairingMachineError.pairingError case.
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
