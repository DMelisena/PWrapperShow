import SwiftUI

public struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @StateObject private var sharedViewModel = CounterViewModel()
    
    enum Tab: CaseIterable {
        case home
//        case stateObject
//        case observedObject
        case environmentObject
        case binding
        case propertyWrappers
        case onboarding
    }
    
    public var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
//                case .stateObject:
//                    StateObjectMainView()
//                case .observedObject:
//                    ObservedMainView()
                case .environmentObject:
                    EnvironmentObjectMainView()
                case .binding:
                    StateAndBindingExample()
                case .propertyWrappers:
                    PropertyWrapperShowcase()
                case .onboarding:
                    HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Text("Environment Count = \(sharedViewModel.count)")
                Spacer()
                HStack(spacing: 0) { // change the Icon to the designed one
                    NavigationButton(icon: "house.fill", selectedTab: .home, currentTab: $selectedTab)
//                    NavigationButton(icon: "1.circle.fill", selectedTab: .stateObject, currentTab: $selectedTab)
//                    NavigationButton(icon: "2.circle.fill", selectedTab: .observedObject, currentTab: $selectedTab)
                    NavigationButton(icon: "3.circle.fill", selectedTab: .environmentObject, currentTab: $selectedTab)
                    NavigationButton(icon: "4.circle.fill", selectedTab: .binding, currentTab: $selectedTab)
                    NavigationButton(icon: "p.circle.fill", selectedTab: .propertyWrappers, currentTab: $selectedTab)
                    NavigationButton(icon: "5.circle.fill", selectedTab: .onboarding, currentTab: $selectedTab)
                }
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.ultraThinMaterial)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 50)
                .padding(.bottom, 34)
            }
        }
        .environmentObject(sharedViewModel)
    }
    
    struct NavigationButton: View {
        let icon: String
        let selectedTab: ContentView.Tab
        @Binding var currentTab: ContentView.Tab
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentTab = selectedTab
                }
            }) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(currentTab == selectedTab ? .white : .gray)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(currentTab == selectedTab ? .blue : .clear)
                            .animation(.easeInOut(duration: 0.2), value: currentTab == selectedTab)
                    )
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
