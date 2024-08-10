// Copyright (c) nami.ai

import SwiftUI

// MARK: - HLine

struct HLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

// MARK: - DashedLineView

struct DashedLineView: View {
    // MARK: Lifecycle

    init(width: CGFloat = 1, dash: [CGFloat] = [], color: Color? = nil) {
        lineWidth = width
        lineDash = dash
        lineColor = color
    }

    // MARK: Internal

    var body: some View {
        HLine()
            .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: lineDash))
            .foregroundColor(lineColor ?? .black)
            .frame(height: lineWidth)
    }

    // MARK: Private

    private let lineWidth: CGFloat
    private let lineDash: [CGFloat]
    private let lineColor: Color?
}

// MARK: - GraphLine

struct GraphLine: View {
    var body: some View {
        DashedLineView(width: 1, dash: [0.5, 1.5], color: .gray.opacity(0.5))
    }
}

// MARK: - LineShape_Previews

struct LineShape_Previews: PreviewProvider {
    static var previews: some View {
        GraphLine()
    }
}
