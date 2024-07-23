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
                    return I18n.errorsPairingErrorDeviceWifiScanError
                case .wifiJoinError:
                    return I18n.errorsPairingErrorDeviceWifiJoinIpError
                case .wifiJoinPasswordError:
                    return I18n.errorsPairingErrorDeviceWifiJoinPasswordError
                default:
                    break
                }
            }
            
            if let error = error as? Pairing.ThreadError {
                switch error {
                case .threadOperationalDatasetMissing:
                    return I18n.errorsPairingThreadSetupErrorThreadOperationalDatasetMissing
                case .threadNetworkNotFound:
                    return I18n.errorsPairingThreadSetupErrorThreadNetworkNotFound
                }
            }
        }
        return I18n.pairingErrorsErrorOccurredTitle
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
            return I18n.errorsPairingMachineUnexpectedState
        case .unexpectedMessage:
            return I18n.errorsPairingMachineUnexpectedMessage
        case .seanceError:
            return I18n.errorsPairingMachineSeanceError
        case let .pairingError(pairingError): // Pairing_Error.
            return pairingError.localizedDescription
        case .serializationError:
            return I18n.errorsPairingMachineSerializationError
        case .deserializationError:
            return I18n.errorsPairingMachineDeserializationError
        case .encryptionError:
            return I18n.errorsPairingMachineEncryptionError
        }
    }
}

// Inner level of PairingMachineError.pairingError case.
extension Pairing_Error {
    var localizedDescription: String {
        switch error {
        case .secureSessionError:
            return I18n.errorsPairingErrorDeviceSecureSessionError
        case .cloudChallengeError:
            return I18n.errorsPairingErrorDeviceCloudChallengeError
        case .wifiScanError:
            return I18n.errorsPairingErrorDeviceWifiScanError
        case .wifiJoinError:
            return I18n.errorsPairingErrorDeviceWifiJoinError
        case .wifiJoinPasswordError:
            return I18n.errorsPairingErrorDeviceWifiJoinPasswordError
        case .wifiJoinIpError:
            return I18n.errorsPairingErrorDeviceWifiJoinIpError
        case .threadJoinError:
            return I18n.pairingErrorsContactSensorSetupErrorUnableJoinThreadNetworksDescription1
            + "\n\n"
            // TODO: input zone name later
            + I18n.pairingErrorsContactSensorSetupErrorUnableJoinThreadNetworksDescription2("")
        default:
            return I18n.errorsPairingErrorDeviceUnknownUnrecognized
        }
    }
}

extension Pairing.ThreadError {
    var localizedDescription: String {
        // TODO: Add errors from I18n.
        switch self {
        case .threadOperationalDatasetMissing:
            return I18n.errorsPairingThreadSetupErrorThreadOperationalDatasetMissing
        case .threadNetworkNotFound:
            return "No Thread network found. Please place your device closer to other Thread devices."
        }
    }
}
