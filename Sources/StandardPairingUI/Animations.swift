// Copyright (c) nami.ai

import Foundation
import Lottie
import SharedAssets

extension Animations {
    private static func localAnimation(named name: String) -> LottieAnimation? {
        guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
            return nil
        }
        return LottieAnimation.filepath(url.path, animationCache: nil)
    }

    // MARK: - Pulse Dark Blue

    var alarmPodPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_Alarm Pod _ Security Pod") }
    var sensePodPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_SensePod") }
    var sensePlugDEPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_SensePlug DE") }
    var sensePlugFRPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_SensePlug FR") }
    var sensePlugUKPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_SensePlug UK") }
    var sensePlugUSPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_SensePlug US") }
    var sensePlugJPPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_SensePlug JP") }

    var widarPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_WiDAR") }

    var wifiSensorDEPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_WiFi DE") }
    var wifiSensorFRPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_WiFi FR") }
    var wifiSensorJPPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_WiFi JP") }
    var wifiSensorUKPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_WiFi UK") }
    var wifiSensorUSPulseDarkBlue: LottieAnimation! { Self.localAnimation(named: "Pulse Dark Blue_WiFi US") }

    // MARK: - Pulse White

    var doorSensorPulseWhite: LottieAnimation! { Self.localAnimation(named: "Pulse White_Door Sensor") }
    var keypadPulseWhite: LottieAnimation! { Self.localAnimation(named: "Pulse White_Keypad") }
    var motionSensorPulseWhite: LottieAnimation! { Self.localAnimation(named: "Pulse White_Motion Sensor") }
}
