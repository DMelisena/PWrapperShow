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

struct EnvironmentObjectCounterViewA: View {
     @ObservedObject var viewModel: CounterViewModel
    let title: String
    let color: Color
    @ObserveInjection var forceRedraw

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("count = \(viewModel.count)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Button("+1") {
                viewModel.addCountValue()
            }
            .font(.body)
            .fontWeight(.semibold)
            .frame(width: 60, height: 40)
            .background(color.opacity(0.6))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(20)
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
struct EnvironmentObjectCounterViewB: View {
     @StateObject var viewModel: CounterViewModel
    let title: String
    let color: Color
    @ObserveInjection var forceRedraw

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("count = \(viewModel.count)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Button("+1") {
                viewModel.addCountValue()
            }
            .font(.body)
            .fontWeight(.semibold)
            .frame(width: 60, height: 40)
            .background(color.opacity(0.6))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(20)
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct EnvironmentObjectMainView: View {
    @State var currentColor: Color = .red
    @ObserveInjection var forceRedraw

    var body: some View {
        VStack(spacing: 30) {
            Button("Alternate Main View") {
                if currentColor == .red {
                    currentColor = .blue
                } else {
                    currentColor = .red
                }
            }
            .font(.title2)
            .fontWeight(.semibold)
            .frame(minWidth: 200, minHeight: 60)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())

            Text("Environment Object Demo")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("Multiple views sharing the same counter state")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            HStack(spacing: 20) {
                EnvironmentObjectCounterViewA(viewModel: CounterViewModel(), title: "ObservedObject", color: .green)
                EnvironmentObjectCounterViewB(viewModel: CounterViewModel(), title: "StateObject", color: .orange)
            }

            EnvironmentObjectView()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(Color.white.opacity(0.4))
        }
        .padding(30)
        .background(currentColor)
        .foregroundColor(.black)
    }
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
//   Would you like me to modify it to show a more realistic EnvironmentObject scenario where the shared state is visible across multiple views?
