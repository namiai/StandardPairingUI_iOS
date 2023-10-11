//
//  SwiftUIView.swift
//  
//
//  Created by Yachin Ilya on 11.10.2023.
//

import SwiftUI

public struct CircleButton: View {
    // MARK: Internal

    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(backgroundColor)

            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(foregroundColor)
                // Hack to maximize the similarity to chevron image asset.
                // SVG has preset 4 px paddings.
                .padding(9)
        }
    }

    // MARK: Private

    private let image: Image = Image(systemName: "chevron.backward")
    private let foregroundColor: Color = Color.black
    private let backgroundColor: Color = Color(UIColor.systemBackground)
}
