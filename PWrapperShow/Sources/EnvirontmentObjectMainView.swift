import SwiftUI

struct EnvironmentObjectView: View {
    @EnvironmentObject var viewModel: CounterViewModel
    @ObserveInjection var forceRedraw

    var body: some View {
        VStack(spacing: 24) {
            Text("Environment Object")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("count = \(viewModel.count)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.vertical, 8)

            Button("+") {
                viewModel.addCountValue()
            }
            .font(.title)
            .fontWeight(.bold)
            .frame(width: 70, height: 70)
            .background(Color.white.opacity(0.4))
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
        .padding(.vertical, 30)
    }
}

struct EnvironmentObjectMainView: View {
    @State var currentColor: Color = .red
    @StateObject private var viewModel = CounterViewModel()
    @ObserveInjection var forceRedraw
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Alternate Main View") {
                if currentColor == .red {
                    currentColor = .blue
                } else {
                    currentColor = .red
                }
            }
            .font(.title)
            .fontWeight(.semibold)
            .frame(minWidth: 220, minHeight: 70)
            .padding(.horizontal, 30)
            .padding(.vertical, 18)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())

            EnvironmentObjectView()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(Color.white.opacity(0.4))
                .padding(.horizontal, 50)
        }
        .padding(30)
        .background(currentColor)
        .foregroundColor(.black)
        .environmentObject(viewModel) }
}

#Preview {
    EnvironmentObjectMainView()
}
// You're absolutely right! Visually, there would be no difference between the StateObject and EnvironmentObject examples as I've implemented them.
//
//   Both create their own CounterViewModel instance in the main view:
//   - StateObjectView: Uses @StateObject var viewModel = CounterViewModel() directly
//   - EnvironmentObjectMainView: Uses @StateObject private var viewModel = CounterViewModel() then passes it via .environmentObject(viewModel)
//
//   The key difference is architectural, not visual:
//   - @StateObject: Direct ownership and access
//   - @EnvironmentObject: Dependency injection through the environment
//
//   To demonstrate the real benefit of @EnvironmentObject, the example should show:
//   1. A shared view model created at a higher level (like in the App or ContentView)
//   2. Multiple child views accessing the same instance through the environment
//   3. Changes in one view reflecting in others
//
