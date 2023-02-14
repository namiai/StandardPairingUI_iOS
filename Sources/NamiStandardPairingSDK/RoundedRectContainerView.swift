// Copyright (c) nami.ai

import SwiftUI

// MARK: - RoundedRectContainerView

struct RoundedRectContainerView<Subviews: View>: View {
    // MARK: Lifecycle

    init(
        cornerRadius: CGFloat = 16.0,
        excludingCorners: UIRectCorner = [],
        shadowRadius: CGFloat? = nil,
        strokeWidth: CGFloat? = nil,
        strokeColor: Color = Color.primary,
        backgroundColor: Color = Color(UIColor.systemBackground),
        @ViewBuilder subviews: () -> Subviews
    ) {
        cornersSettableRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
        bgColor = backgroundColor
        self.subviews = subviews()
        roundedCorners = UIRectCorner(rawValue: UIRectCorner.allCorners.rawValue - excludingCorners.rawValue)
    }

    // MARK: Internal

    var subviews: Subviews
    var roundedCorners: UIRectCorner
    var cornersSettableRadius: CGFloat
    var shadowRadius: CGFloat?
    var strokeWidth: CGFloat?
    var strokeColor: Color
    var bgColor: Color

    var body: some View {
        VStack {
            subviews
        }
        .frame(maxWidth: .infinity, alignment: .center)
        // Setting corner radius to 0 is a hack
        // allowing to clip overflowing subviews,
        // Actual corners shape and radius is set through background.
        .cornerRadius(0)
        .background(SelectiveCornerRoundedShape(radius: Double(cornersSettableRadius), corners: roundedCorners)
            .fill(bgColor, strokeColor: strokeColor, lineWidth: strokeWidth ?? 0)
        )
        .shadow(radius: shadowRadius)
    }

    // MARK: Private

    private struct SelectiveCornerRoundedShape: Shape {
        var radius: Double
        var corners: UIRectCorner

        func path(in rect: CGRect) -> Path {
            Path(
                UIBezierPath(
                    roundedRect: rect,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                )
                .cgPath
            )
        }
    }
}

private extension View {
    @ViewBuilder
    func shadow(radius: CGFloat?) -> some View {
        if let r = radius, r.isZero == false { shadow(radius: r) }
        else { self }
    }
}

private extension Shape {
    func fill<Fill: ShapeStyle>(
        _ fillStyle: Fill,
        strokeColor: Color,
        lineWidth: CGFloat = 1
    ) -> some View {
        stroke(strokeColor, lineWidth: lineWidth)
            .background(fill(fillStyle))
    }
}

// MARK: - RoundedRectContainerView_Preview

struct RoundedRectContainerView_Preview: PreviewProvider {
    @Environment(\.colors) static var colors: Colors
    @Environment(\.images) static var images: Images
    @State static var tag = 1

    static var previews: some View {
        ZStack {
            colors.lowerBackground.edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    RoundedRectContainerView(
                        excludingCorners: [.topLeft, .bottomRight],
                        strokeWidth: 1,
                        strokeColor: .accentColor,
                        backgroundColor: .white
                    ) {
                        VStack {
                            Text("Some meaningful text")
                            Text("More text")
                        }.padding()
                    }.padding()

                    RoundedRectContainerView(
                        backgroundColor: colors.forTheme(3, saturation: .lite)
                    ) {
                        BarPlot<UInt64>(dataPoints: [10.1, 0.3, 0.5, 7.3, 4.9, 5.5], color: colors.forTheme(3, saturation: .saturated), style: .continuous, showValues: .relative)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 220)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 220)
                .padding()
                RoundedRectContainerView(
                    backgroundColor: colors.forTheme(5, saturation: .lite)
                ) {
                    VStack {
                        HStack {
                            images.devices.image(for: "scout")
                            images.devices.image(for: "sentinel")
                            images.devices.image(for: "defender")
                        }
                        HStack {
                            images.devices.image(for: "scout-uk")
                            images.devices.image(for: "sentinel")
                            images.devices.image(for: "defender")
                        }
                        HStack {
                            images.devices.image(for: "scout-us")
                            images.devices.image(for: "sentinel")
                            images.devices.image(for: "defender")
                        }
                    }.padding()
                }.padding()
            }
        }

        ZStack {
            colors.lowerBackground.edgesIgnoringSafeArea(.all)
            VStack {
                RoundedRectContainerView(
                    backgroundColor: .white
                ) {
                    VStack {
                        HStack {
                            Text("Activity")
                                .font(NamiTextStyle.headline2.font)
                                .foregroundColor(colors.bodyText)
                            Spacer()
                        }
                        BarPlot<UInt64>(
                            dataPoints:
                            (0..<24).enumerated().map { _ in
                                Double.random(in: 0...100)
                            },
                            color: colors.forTheme(1, saturation: .saturated),
                            style: .discrete(steps: 8),
                            showValues: .relative
                        )
                        .padding(.horizontal, 8)
                        Picker("", selection: $tag) {
                            Text("month").tag(0)
                            Text("week").tag(1)
                            Text("day").tag(2)
                            Text("hour").tag(3)
                        }.pickerStyle(SegmentedPickerStyle())
                    }.frame(maxHeight: 220)
                        .padding()
                }.padding()

                RoundedRectContainerView(
                    backgroundColor: .white
                ) {
                    VStack {
                        WaveformPlot(
                            dataPoints: (0..<12).enumerated().map { _ in
                                Double.random(in: 0...100)
                            },
                            strokeColor: colors.forTheme(2, saturation: .saturated)
                        )
                        .padding(.vertical)
                        HStack {
                            Text("3 hr ago").font(NamiTextStyle.small.font)
                            Spacer()
                            Text("2 hr ago").font(NamiTextStyle.small.font)
                            Spacer()
                            Text("1 hr ago").font(NamiTextStyle.small.font)
                            Spacer()
                            Text("Recently").font(NamiTextStyle.small.font)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }.frame(maxWidth: .infinity, maxHeight: 220)
                }.padding()

                RoundedRectContainerView(
                    backgroundColor: colors.forTheme(5, saturation: .normal)
                ) {
                    HStack {
                        VStack {
                            HStack {
                                Text("San Bernadino")
                                    .font(NamiTextStyle.headline3.font)
                                Spacer()
                            }
                            WaveformPlot(
                                dataPoints: (0..<12).enumerated().map { _ in
                                    Double.random(in: 0...100)
                                },
                                strokeColor: colors.forTheme(5, saturation: .saturated)
                            )
                            .frame(maxHeight: 45)
                            Spacer()
                        }.padding()
                        Image(images.places.imageName(from: 7, variant: .squared))
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 140)
                }
                .padding()
            }
        }
    }
}
