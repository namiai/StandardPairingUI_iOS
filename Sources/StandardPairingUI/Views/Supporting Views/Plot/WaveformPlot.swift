// Copyright (c) nami.ai

import SwiftUI

// MARK: - WaveformPlot

struct WaveformPlot: View {
    // MARK: Lifecycle

    /// WaveformPlot made for visualizing only values in a range `0...Double.greatestFiniteMagnitude`.
    ///
    /// Please note that the negative values are possible to be plotted but it may and would overflow the plot designated view.
    /// - Parameter dataPoints: The values to be plotted.
    /// - Parameter nagativeHandling: A strategy to handle the negative values. When set to `.none` negative values are allowed to be plotted but it may break the view layout (layout overflows should be habdled by the parent view). When negative values should be excluded from the plot it may be set to `.zero` to treat the negative as 0 or `.magnitude` to treat the values ignoring the sign. Also the custom strategy may be used with `.custom((Double)->Double)`. All the negative values would be processed with the provided closure.
    /// - Parameter showValues: A style of the values representation. May be absolute or relative. Absolute representation takes the values as the per cent of plot height, values over 100 are truncated (shown as 100%). Relative representation adjusts the biggest value of `dataPoints` to be 100%, all other values are plotted relatively to the biggest one.
    /// - Parameter strokeColor: Color for line representing the values.
    /// - Parameter strokeStyle: Sets the style of the line visualizing the data points on a plot.
    init(
        dataPoints: [Double],
        nagativeHandling: NegativeValuesHandlingStrategy = .magnitude,
        showValues: ValueRepresentation = .absolute,
        strokeColor: Color = Color.primary,
        strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [], dashPhase: 10)
    ) {
        self.dataPoints = dataPoints
        self.nagativeHandling = nagativeHandling
        self.showValues = showValues
        self.strokeColor = strokeColor
        self.strokeStyle = strokeStyle
    }

    // MARK: Internal

    enum NegativeValuesHandlingStrategy {
        case none
        case zero
        case magnitude
        case custom((Double) -> Double)
    }

    var body: some View {
        GeometryReader { geometry in
            drawDatapointsGraph(points: dataPoints, maxWidth: geometry.size.width, maxHeight: geometry.size.height, negativeHandling: nagativeHandling, showValues: showValues)
                .stroke(strokeColor, style: strokeStyle)
        }
    }

    // MARK: Private

    private let strokeStyle: StrokeStyle
    private let strokeColor: Color

    private let dataPoints: [Double]
    private let nagativeHandling: NegativeValuesHandlingStrategy
    private let showValues: ValueRepresentation

    private func pointsWithAppliedStrategies(_ points: [Double], negativeHandling: NegativeValuesHandlingStrategy, showValues: ValueRepresentation) -> [Double] {
        points
            .map { p -> Double in
                switch negativeHandling {
                case .none:
                    return p
                case .zero:
                    return p < 0 ? 0 : p
                case .magnitude:
                    return p.magnitude
                case let .custom(strategy):
                    return p < 0 ? strategy(p) : p
                }
            }
            .map { p -> Double in
                if showValues == .absolute {
                    if p > 100 { return 100 }
                    if p < 0 { return 0 }
                }
                return p
            }
    }

    private func minMaxValuesRange(points: [Double], showValues: ValueRepresentation) -> CGFloat {
        if showValues == .absolute { return 100 }
        let max = points.max() ?? 0
        let min = points.min() ?? 0
        let diff = max - min
        if diff.isZero { return 1 }
        return CGFloat(diff)
    }

    private func pointsValueCorrection(maxHeight: CGFloat, range: CGFloat) -> CGFloat {
        maxHeight / range
    }

    private func drawDatapointsGraph(points: [Double], maxWidth width: CGFloat, maxHeight height: CGFloat, negativeHandling: NegativeValuesHandlingStrategy, showValues: ValueRepresentation) -> Path {
        let points = pointsWithAppliedStrategies(points, negativeHandling: negativeHandling, showValues: showValues)
        if points.isEmpty {
            return Path { path in
                path.move(to: CGPoint(x: 0, y: height))
                path.addLine(to: CGPoint(x: width, y: height))
            }
        }

        let pointsCount = points.count
        let stepWidth = pointsCount == 1 ? width : width / CGFloat(pointsCount - 1)
        let halfStep = stepWidth / 2
        let correction = pointsValueCorrection(
            maxHeight: height,
            range: minMaxValuesRange(points: points, showValues: showValues)
        )

        return Path { path in
            var lastValue: Double!
            points.enumerated().forEach { i, p in
                defer { lastValue = p }
                if i == 0 {
                    path.move(to: CGPoint(x: 0, y: -correction * CGFloat(p) + height))
                    if pointsCount == 1 {
                        path.addLine(to: CGPoint(x: stepWidth, y: -correction * CGFloat(p) + height))
                    }
                    return
                }
                let nextTargetPoint = CGPoint(x: stepWidth * CGFloat(i), y: -correction * CGFloat(p) + height)
                let leftControl = CGPoint(x: nextTargetPoint.x - halfStep, y: -correction * CGFloat(lastValue) + height)
                let rightControl = CGPoint(x: nextTargetPoint.x - halfStep, y: -correction * CGFloat(p) + height)
                path.addCurve(to: nextTargetPoint, control1: leftControl, control2: rightControl)
            }
        }
    }
}

// MARK: - WaveformPlot_Previews

struct WaveformPlot_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedRectContainerView {
                WaveformPlot(dataPoints: [0.5, 1, 2, 5, 10, 30, 50, 100], strokeColor: .pink)
                    .frame(height: 100, alignment: .center)
                    .padding()
            }.shadow(radius: 5)

            RoundedRectContainerView {
                WaveformPlot(dataPoints: [1, 0.3, 1, 0.7, 0.5, 0.9, 0, 0.3, 0.1, 0.0, 0.3, 0.1, 1.0, 0.9, 0, 0.0, 1.0], showValues: .relative, strokeColor: .yellow)
                    .frame(height: 100, alignment: .center)
                    .padding()
            }.shadow(radius: 5)

            RoundedRectContainerView {
                WaveformPlot(dataPoints: [-10, -20, 30, 40, -50, 70, -100], nagativeHandling: .magnitude, showValues: .relative, strokeColor: .blue)
                    .frame(height: 100, alignment: .center)
                    .padding()
            }.shadow(radius: 5)

            RoundedRectContainerView {
                WaveformPlot(dataPoints: [-10, -20, 30, 40, -50, 70, -100], nagativeHandling: .zero, showValues: .relative, strokeColor: .green)
                    .frame(height: 100, alignment: .center)
                    .padding()
            }.shadow(radius: 5)
        }.padding()
    }
}
