//
//  HorizontalGauge.swift
//
//
//  Created by Gleb Vodovozov on 19/8/24.
//

import Foundation
import SwiftUI

struct WidarPositioningQualityGauge: View {
    init(
        currentValue: Int,
        minValue: Int,
        maxValue: Int,
        goodThreshold: Int,
        strokeColor: Color = Color.primary,
        strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [], dashPhase: 10)
    ) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.goodThreshold = goodThreshold
        self.currentValue = currentValue
        self.strokeColor = strokeColor
        self.strokeStyle = strokeStyle
    }
    
    private let minValue: Int
    private let maxValue: Int
    private let goodThreshold: Int
    private let currentValue: Int
    private let strokeStyle: StrokeStyle
    private let strokeColor: Color
    private let gaugeHeight:CGFloat = 15.0
    private let badColor: Color = .yellow
    private let goodColor: Color = .green
    
    var body: some View {
        GeometryReader { geometry in
            drawCurrentValue(gaugeEndLocationX: calculateXLocation(maxWidth: geometry.size.width, value: self.currentValue))
                .animation(.smooth, value: self.currentValue)
                .foregroundColor(self.currentValue < self.goodThreshold ? self.badColor : self.goodColor)
                .saturation(saturationForValue(value: self.currentValue))
            drawBorders(maxWidth: geometry.size.width).stroke(style: self.strokeStyle).foregroundColor(self.strokeColor)
            drawThresholdLine(locationX: calculateXLocation(maxWidth: geometry.size.width, value: self.goodThreshold)).stroke(style: self.strokeStyle).foregroundColor(self.strokeColor)
        }
        .frame(height: gaugeHeight, alignment: .center)
    }
    
    private func drawBorders(maxWidth: CGFloat) -> Path {
        return Path { path in
            path.addRoundedRect(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: gaugeHeight)), cornerSize: CGSize(width: 4.0, height: 4.0))
        }
    }
    
    private func drawThresholdLine(locationX: CGFloat) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: locationX, y: -5))
            path.addLine(to: CGPoint(x: locationX, y: gaugeHeight + 5))
            
        }
    }
    
    private func drawCurrentValue(gaugeEndLocationX: CGFloat) -> Path {
        return Path { path in
            path.addRoundedRect(in: CGRect(origin: .zero, size: CGSize(width: gaugeEndLocationX, height: gaugeHeight)), cornerSize: CGSize(width: 4.0, height: 4.0))
        }
    }
    
    private func calculateXLocation(maxWidth: CGFloat, value: Int) -> CGFloat {
        if value <= self.minValue {
            return 0.0
        }
        let range = CGFloat(self.maxValue - self.minValue)
        if range == 0 {
            return 0
        }
        let rangeToValue = CGFloat(value - self.minValue)
        return maxWidth / range * rangeToValue
    }
    
    private func saturationForValue(value: Int) -> Double {
        let range = self.maxValue - self.goodThreshold
        if range == 0 {
            return 0.0
        }
        if value < self.goodThreshold {
            return 1.0
        }
        if value > self.maxValue {
            return 1.0
        }
        let distanceFromThreshold = value - self.goodThreshold
        let saturation = Double(distanceFromThreshold) / Double(range)
        
        return saturation * 0.8 + 0.2
    }
}
