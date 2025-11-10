//
//  RootTab.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

enum RootTab: Int, CaseIterable {
    case main
    case appointmentList
    case contact
    case profile

    var idleImage: Image {
        switch self {
        case .main:
            return Asset.Images.tabMainIdle.swiftUIImage
        case .appointmentList:
            return Asset.Images.tabListIdle.swiftUIImage
        case .contact:
            return Asset.Images.tabContactIdle.swiftUIImage
        case .profile:
            return Asset.Images.tabProfileIdle.swiftUIImage
        }
    }

    var selectedImage: Image {
        switch self {
        case .main:
            return Asset.Images.tabMainSelected.swiftUIImage
        case .appointmentList:
            return Asset.Images.tabListSelected.swiftUIImage
        case .contact:
            return Asset.Images.tabContactSelected.swiftUIImage
        case .profile:
            return Asset.Images.tabProfileSelected.swiftUIImage
        }
    }
}

struct RootTabView: View {

    @State private var selectedTab: RootTab = .main

    var body: some View {
        ZStack(alignment: .bottom) {
            content(for: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

private extension RootTabView {

    @ViewBuilder
    func content(for tab: RootTab) -> some View {
        switch tab {
        case .main:
            MainView()
        case .appointmentList:
            AppointmentsView()
        case .contact:
            ContactView()
        case .profile:
            ProfileView()
        }
    }
}

private struct CustomTabBar: View {

    @Binding var selectedTab: RootTab

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                ForEach(RootTab.allCases, id: \.self) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        tabImage(for: tab)
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                }
            }
        }
        .background(
            Asset.Colors.f5F5F5.swiftUIColor
                .ignoresSafeArea(edges: .bottom)
        )
    }

    private func tabImage(for tab: RootTab) -> Image {
        selectedTab == tab ? tab.selectedImage : tab.idleImage
    }
}
