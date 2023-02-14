// Copyright (c) nami.ai

import SwiftUI
import UIKit

// MARK: - NamiTextFieldStyle

enum NamiTextFieldStyle {
    case neutral
    case positive
    case negative
}

// MARK: - NamiTextField

struct NamiTextField: View {
    // MARK: Lifecycle

    init(placeholder: String, text: Binding<String>, isEditing: Binding<Bool>? = nil, returnKeyType: UIReturnKeyType = .default) {
        self.placeholder = placeholder
        self.returnKeyType = returnKeyType
        _text = text
        isEditingExternal = isEditing
    }

    // MARK: Internal

    @Environment(\.colors) var colors: Colors
    var fieldStyle: NamiTextFieldStyle = .neutral
    /// The text under the textfield. If present, will be rendered
    /// in the given ``style``.
    var fieldSubText: String?
    var secureTextEntry = false

    var body: some View {
        VStack {
            RoundedRectContainerView(
                cornerRadius: cornerRadius,
                strokeWidth: 1.0,
                strokeColor: strokeColorWithStyle
            ) {
                TextFieldView(placeholder: placeholder, text: $text, isEditing: isEditing, returnKeyType: returnKeyType)
                    .font(NamiTextStyle.paragraph1.uiFont)
                    .tintColor(colors.accent)
                    .secureTextEntry(secureTextEntry)
                    .padding()
            }
            if let subTextPresent = fieldSubText {
                HStack {
                    Text(subTextPresent)
                        .font(NamiTextStyle.small.font)
                        .foregroundColor(subTextColorWithStyle)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: cornerRadius * 0.5, bottom: 0, trailing: cornerRadius * 0.5))
            }
        }
    }

    var strokeColorWithStyle: Color {
        switch fieldStyle {
        case .neutral:
            if isEditing.wrappedValue {
                return colors.accent
            } else {
                return colors.borderStroke
            }
        case .positive:
            return colors.positive
        case .negative:
            return colors.negative
        }
    }

    var subTextColorWithStyle: Color {
        switch fieldStyle {
        case .neutral:
            return colors.bodyText
        case .positive:
            return colors.positive
        case .negative:
            return colors.negative
        }
    }

    // MARK: Private

    private let cornerRadius: CGFloat = 16.0
    private var placeholder: String
    private var returnKeyType: UIReturnKeyType
    @Binding private var text: String
    @State private var isEditingInternal = false
    private var isEditingExternal: Binding<Bool>?

    private var isEditing: Binding<Bool> {
        isEditingExternal ?? $isEditingInternal
    }
}

// MARK: - NamiTextField_Previews

struct NamiTextField_Previews: PreviewProvider {
    @State static var emptyText = ""
    @State static var text = "Input text"
    @State static var isEditing = true

    static var previews: some View {
        VStack {
            Group {
                NamiTextField(placeholder: "Placeholder", text: $emptyText)
                NamiTextField(placeholder: "Placeholder", text: $text)
                    .subText("Required")
                NamiTextField(placeholder: "Placeholder", text: $text, isEditing: $isEditing)
                NamiTextField(placeholder: "Placeholder", text: $text)
                    .subText("Error message")
                    .style(.negative)
                NamiTextField(placeholder: "Placeholder", text: $text)
                    .subText("Success message")
                    .style(.positive)
                NamiTextField(placeholder: "Placeholder", text: $emptyText)
                    .secureTextEntry(true)
                NamiTextField(placeholder: "Placeholder", text: $text)
                    .secureTextEntry(true)
            }
            .padding()
        }
        .previewLayout(.fixed(width: 400, height: 800))
    }
}
