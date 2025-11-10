import SwiftUI

enum RootTab: Int, CaseIterable, Hashable {
    case main
    case appointments
    case contact
    case profile
}

private extension RootTab {
    
    var title: String {
        switch self {
        case .main:
            return "Main"
        case .appointments:
            return "Appointments"
        case .contact:
            return "Contact"
        case .profile:
            return "Profile"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .main:
            return "house.fill"
        case .appointments:
            return "list.bullet.rectangle"
        case .contact:
            return "message"
        case .profile:
            return "person.crop.circle"
        }
    }
}

struct GCTabView: View {
    @State private var selectedTab: RootTab = .main
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Label(RootTab.main.title, systemImage: RootTab.main.systemImageName)
                }
                .tag(RootTab.main)
            
            AppointmentsView()
                .tabItem {
                    Label(RootTab.appointments.title, systemImage: RootTab.appointments.systemImageName)
                }
                .tag(RootTab.appointments)
            
            ContactView()
                .tabItem {
                    Label(RootTab.contact.title, systemImage: RootTab.contact.systemImageName)
                }
                .tag(RootTab.contact)
            
            ProfileView()
                .tabItem {
                    Label(RootTab.profile.title, systemImage: RootTab.profile.systemImageName)
                }
                .tag(RootTab.profile)
        }
    }
}
