// Copyright (c) nami.ai

import Foundation
import I18n
import NamiProto
import Tomonari
import SharedAssets

// Upper level of matryoshka.
public extension Pairing.Error {
    var errorMessageTitle: String {
        if case let .underlying(error) = self {
            if let error = error as? PairingMachineError, case let .pairingError(e) = error {
                switch e.error {
                case .wifiScanError:
                    return I18n.Errors.PairingMachine.notFoundAvailableWifiTitle
                case .wifiJoinError:
                    return I18n.Errors.PairingMachine.notJoinWifiTitle
                case .threadJoinError:
                    return I18n.Errors.PairingMachine.notJoinThreadTitle
                case .wifiJoinPasswordError:
                    return I18n.Errors.PairingMachine.passwordWifiWasRejectedTitle
                default:
                    break
                }
            }
            
            if let error = error as? Pairing.ThreadError {
                switch error {
                case .threadOperationalDatasetMissing:
                    return I18n.Errors.PairingThreadSetupError.threadOperationalDatasetMissingTitle
                case .threadNetworkNotFound:
                    return I18n.Errors.PairingThreadSetupError.threadNetworkNotFoundTitle
                case .mixedEnvironment:
                    return I18n.Errors.PairingThreadSetupError.mixedEnvironmentTitle
                }
            }
            
            if let error = error as? PairingMachineError, case .notSupportDeviceType(_) = error {
                return I18n.Errors.PairingMachine.notSupportDevcieTypeTitle
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
    
    var FAQLink: String? {
        if case let .underlying(error) = self {
            if let error = error as? Pairing.ThreadError {
                switch error {
                case .threadNetworkNotFound:
                    return URLLinks.FAQNotConnectToThread
                default:
                    return nil
                }
            }
        }
        return nil
    }
}

extension PairingMachineError {
    var localizedDescription: String {
        switch self {
        case .unexpectedState:
            // We don't need a message for unexpceted state error
            return ""
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
        case let .notSupportDeviceType(deviceTypes):
            return I18n.Errors.PairingMachine.notSupportDevcieTypeDescription
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
        case .threadJoinError:
            return I18n.Errors.PairingErrorDevice.threadJoinErrorDescription1
            + "\n\n"
            // TODO: input zone name later
            + I18n.Errors.PairingErrorDevice.threadJoinErrorDescription2("")
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
        case let .threadNetworkNotFound(zoneName, deviceType):
            switch deviceType {
            case .contactSensor:
                return I18n.Errors.PairingThreadSetupError.threadNetworkNotFound_contactsensor(zoneName)
            default:
                return I18n.Errors.PairingThreadSetupError.threadNetworkNotFound_general(zoneName)
            }
        case .mixedEnvironment:
            return I18n.Errors.PairingThreadSetupError.mixedEnvironment
        }
    }
}
