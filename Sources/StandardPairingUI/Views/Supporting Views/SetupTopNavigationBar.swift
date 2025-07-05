// Copyright (c) nami.ai

import SwiftUI
import NamiSharedUIElements

// Project Skateboard iteration of a custom navbar.
// In Notion documentation it is denoted just as Skateboard:
// an unscrollable navbar accomodating a page title, back button, one or two control buttons on a trailing brim and optional additional subviews below the title.

public struct SetupTopNavigationBar<LeadingGroup: View, TrailingGroup: View, NotificationArea: View, Subviews: View>: View {
    // MARK: Lifecycle
    
    public init(
        title: String?,
        largeTitle: String?,
        color: Color,
        statusbarColorOverride: Color = .clear,
        navbarBackgroundBleed: CGFloat = 0, // How far to bleed the background below the navbar frame.
        @ViewBuilder leadingButtonGroup: @escaping () -> LeadingGroup = { EmptyView() },
        @ViewBuilder trailingButtonGroup: @escaping () -> TrailingGroup = { EmptyView() },
        @ViewBuilder notificationAreaView: @escaping () -> NotificationArea = { EmptyView() },
        @ViewBuilder additionalViews: @escaping () -> Subviews = { EmptyView() }
    ) {
        self.title = title
        self.largeTitle = largeTitle
        self.color = color
        self.statusbarColorOverride = statusbarColorOverride
        self.navbarBackgroundBleed = navbarBackgroundBleed
        self.leadingButtonGroup = leadingButtonGroup
        self.trailingButtonGroup = trailingButtonGroup
        self.notificationAreaView = notificationAreaView
        subviews = additionalViews
    }
    
    // MARK: Internal
    
    var title: String?
    var largeTitle: String?
    var color: Color
    var statusbarColorOverride: Color
    var navbarBackgroundBleed: CGFloat
    var leadingButtonGroup: () -> LeadingGroup
    var trailingButtonGroup: () -> TrailingGroup
    var notificationAreaView: () -> NotificationArea
    var subviews: () -> Subviews
    
    @State private var notificationAreaHeight: CGFloat = 0
    @Environment(\.themeManager) private var themeManager
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                gradientBackground()
                    .frame(height: statusbarShift)
                
                statusbarColorOverride
                    .frame(height: statusbarShift)
            }
            
            notificationAreaView()
            
            ZStack(alignment: .center) {
                HStack {
                    leadingButtonGroup()
                    Spacer()
                    trailingButtonGroup()
                }
                
                Text(title ?? "", font: themeManager.selectedTheme.headline5)
                    .fillWidth(alignment: .center)
            }
            .frame(height: defaultNavbarHeight)
            .padding(.horizontal)
            
            VStack(spacing: 0) {
                if let largeTitle, largeTitle.isEmpty == false {
                    SetupScreenTitleTextView(title: largeTitle)
                        .padding(.top, 16)
                        .padding(.horizontal)
                }
                subviews()
            }
        }
        .background(gradientBackground())
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: Private
    
    private func gradientBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                    [1, 1, 1, 1, 1, 1, 1, 0.95, 0.8, 0].map { v in
                        color
                            .opacity(
                                Double(v)
                            )
                    }
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
