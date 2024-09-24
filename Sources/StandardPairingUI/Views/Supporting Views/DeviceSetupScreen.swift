// Copyright (c) nami.ai

import I18n
import SwiftUI
import SharedAssets
import NamiSharedUIElements

// MARK: - DeviceSetupScreen

// MARK: - DeviceSetupScreen

public struct DeviceSetupScreen<LeadingGroup: View, Subview: View, BottomGroup: View>: View {
    // MARK: Lifecycle
    
    public init(
        title: String,
        @ViewBuilder subview: @escaping () -> Subview, 
        @ViewBuilder leadingButtonsGroup: @escaping () -> LeadingGroup = { EmptyView() },
        @ViewBuilder bottomButtonsGroup: @escaping () -> BottomGroup = { EmptyView() }
    ) {
        self.title = title
        self.leadingButtonsGroup = leadingButtonsGroup
        self.subview = subview
        self.bottomButtonsGroup = bottomButtonsGroup
    }

    // MARK: Public

    public var body: some View {
        ZStack {
            themeManager.selectedTheme.background
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                subview()
                    .frame(maxHeight: .infinity)
                bottomButtonsGroup()
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) { 
                VStack {
                    Text(title)
                        .font(themeManager.selectedTheme.headline5)
                        .foregroundColor(themeManager.selectedTheme.navigationTitleColor)
                }
            }
        }
        .navigationBarItems(leading: EmptyView())        

    }

    // MARK: Private

    @EnvironmentObject private var themeManager: ThemeManager
    private let title: String
    private let subview: () -> Subview
    private var leadingButtonsGroup: () -> LeadingGroup
    private var bottomButtonsGroup: () -> BottomGroup
}

// MARK: - DeviceSetupScreen_Previews

struct DeviceSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSetupScreen(title: "Setup device") {
            Text("So removed, we spoke of wintertime in France")
            Button("Ride on the metro") {
                print("I was on a Paris train, I emerged in London rain")
            }
        }
    }
}
