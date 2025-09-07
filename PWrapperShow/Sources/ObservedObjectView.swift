import SwiftUI

struct ObservedObjectView: View {
    @ObservedObject var viewModel = CounterViewModel()
    @ObserveInjection var forceRedraw

    var body: some View {
        VStack(spacing: 20) {
            Text("Observed Object")
                .font(.title2)
                .fontWeight(.medium)

            Text("count = \(viewModel.count)")
                .font(.title)
                .fontWeight(.bold)

            Button("+") {
                viewModel.addCountValue()
            }
            .font(.largeTitle)
            .frame(width: 60, height: 60)
            .background(Color.white.opacity(0.3))
            .clipShape(Circle())
        }
    }
}

struct ObservedMainView: View {
    @State var currentColor: Color = .red
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

            ObservedObjectView()
        }
        .padding(30)
        .background(currentColor)
        .foregroundColor(.black)
    }
}

#Preview {
    ContentView()
}
