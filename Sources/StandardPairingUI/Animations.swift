// Copyright (c) nami.ai

import Foundation
import Lottie
import SharedAssets

extension Animations {
    
    private func animationLocalFirst(_ name: String) -> LottieAnimation? {
        let prioritisedBundle: Bundle!
        #if SWIFT_PACKAGE
        prioritisedBundle = .module
        #else
        prioritisedBundle = .main
        #endif
        return LottieAnimation.named(name, bundle: prioritisedBundle) ?? animationNamed(name)
    }

    // MARK: - Pulse Dark Blue

    var alarmPodPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_Alarm Pod _ Security Pod") }
    var sensePodPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_SensePod") }
    var sensePlugDEPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_SensePlug DE") }
    var sensePlugFRPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_SensePlug FR") }
    var sensePlugUKPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_SensePlug UK") }
    var sensePlugUSPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_SensePlug US") }
    var sensePlugJPPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_SensePlug JP") }

    var widarPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_WiDAR") }

    var wifiSensorDEPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_WiFi DE") }
    var wifiSensorFRPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_WiFi FR") }
    var wifiSensorJPPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_WiFi JP") }
    var wifiSensorUKPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_WiFi UK") }
    var wifiSensorUSPulseDarkBlue: LottieAnimation! { animationLocalFirst("Pulse Dark Blue_WiFi US") }

    // MARK: - Pulse White

    var doorSensorPulseWhite: LottieAnimation! { animationLocalFirst("Pulse White_Door Sensor") }
    var keypadPulseWhite: LottieAnimation! { animationLocalFirst("Pulse White_Keypad") }
    var motionSensorPulseWhite: LottieAnimation! { animationLocalFirst("Pulse White_Motion Sensor") }
}
