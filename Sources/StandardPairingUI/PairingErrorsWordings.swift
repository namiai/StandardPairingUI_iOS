// Copyright (c) nami.ai

import Foundation
import Tomonari
import NamiProto

public extension Pairing.Error {
    func getErrorMessageTitle(wordings: WordingProtocol) -> String {
        if case let .underlying(error) = self {
            if let error = error as? PairingMachineError, case let .pairingError(e) = error {
                switch e.error {
                case .wifiScanError:
                    return wordings.pairingErrorDeviceWifiScanTitle
                case .wifiJoinError:
                    return wordings.pairingErrorDeviceWifiJoinPasswordTitle
                case .wifiJoinPasswordError:
                    return wordings.pairingErrorDeviceWifiJoinPasswordTitle
                default:
                    break
                }
            }
            
            if let error = error as? Pairing.ThreadError {
                switch error {
                case .threadOperationalDatasetMissing:
                    return wordings.pairingThreadErrorDatasetMissingTitle
                case .threadNetworkNotFound:
                    return wordings.pairingThreadErrorThreadNetworkNotFoundTitle
                }
            }
            
            if let error = error as? PairingMachineError, case .notSupportDeviceType(_) = error {
                return wordings.pairingErrorDeviceMismatchTitle
            }
            
            if let error = error as? PairingMachineError, case .connectionTimeOutError = error {
                return wordings.pairingErrorConnectionTimeoutTitle
            }
            
            if let error = error as? PairingMachineError, case .bluetoothDisconnectedError(_, _) = error {
                return wordings.pairingErrorBleDisconnectedTitle
            }
        }
        return wordings.pairingErrorOccurredTitle
    }
    
    func getErrorMessageDescription(wordings: WordingProtocol) -> String {
        switch self {
        case let .underlying(error):
            if let error = error as? PairingMachineError {
                return error.getErrorMessageDescription(wordings: wordings)
            }
            if let error = error as? PairingNetworkError {
                return error.localizedDescription
            }
            if let error = error as? Pairing.ThreadError {
                return error.getErrorMessageDescription(wordings: wordings)
            }
//            return error.localizedDescription
            return ""
        }
    }
}

extension PairingMachineError {
    func getErrorMessageDescription(wordings: WordingProtocol) -> String {
        switch self {
        case .unexpectedState:
            return wordings.pairingErrorUnexpectedStateDescription
        case .unexpectedMessage:
            return wordings.pairingErrorUnexpectedMessageDescription
        case .seanceError:
            return wordings.pairingErrorSeanceDescription
        case let .pairingError(pairingError): // Pairing_Error.
            return pairingError.getErrorMessageDescription(wordings: wordings)
        case .serializationError:
            return wordings.pairingErrorSerializationDescription
        case .deserializationError:
            return wordings.pairingErrorDeserializationDescription
        case .encryptionError:
            return wordings.pairingErrorEncryptionErrorDescription
        case let .notSupportDeviceType(deviceType):
            return wordings.pairingErrorDeviceMismatchDescription
        case .connectionTimeOutError:
            return wordings.pairingErrorConnectionTimeoutDescription
        case let .bluetoothDisconnectedError(deviceType, canTryAgain):
            if canTryAgain {
                if deviceType == .unknown {
                    return wordings.pairingErrorBleDisconnectedDescription(deviceName: "device")
                }
                
                return wordings.pairingErrorBleDisconnectedDescription(deviceName: deviceType.localizedName)
            } 
    
            return ""
        }
    }
}

// Inner level of PairingMachineError.pairingError case.
extension Pairing_Error {
    func getErrorMessageDescription(wordings: WordingProtocol) -> String {
        switch error {
        case .secureSessionError:
            return wordings.pairingErrorDeviceSecureSessionDescription
        case .cloudChallengeError:
            return wordings.pairingErrorDeviceCloudChallengeDescription
        case .wifiScanError:
            return wordings.pairingErrorDeviceWifiScanDescription
        case .wifiJoinError:
            return wordings.pairingErrorDeviceWifiJoinDescription
        case .wifiJoinPasswordError:
            return wordings.pairingErrorDeviceWifiJoinPasswordDescription
        case .wifiJoinIpError:
            return wordings.pairingErrorDeviceWifiJoinPasswordDescription
        case .threadJoinError:
            return wordings.pairingErrorsUnableJoinThreadNetworksDescription1
            + "\n\n"
            // TODO: input zone name later
            + wordings.pairingErrorsUnableJoinThreadNetworksDescription2(zoneName: "")
        default:
            return wordings.pairingErrorDeviceUnknownUnrecognizedDescription
        }
    }
}

extension Pairing.ThreadError {
    func getErrorMessageDescription(wordings: WordingProtocol) -> String {
        switch self {
        case .threadOperationalDatasetMissing:
            return wordings.pairingThreadErrorDatasetMissingDescription
        case let .threadNetworkNotFound(zoneName, deviceType):
            switch deviceType {
            case .contactSensor:
                return wordings.pairingThreadErrorContactSensorNoThreadNetworksFoundDescription1(zoneName: zoneName)
            default:
                return wordings.pairingThreadErrorNoThreadNetworksFoundDescription(zoneName: zoneName)
            }
        }
    }
}
