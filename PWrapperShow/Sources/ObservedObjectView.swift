import SwiftUI

struct ObservedObjectView: View {
    @ObservedObject var viewModel = CounterViewModel()
    @ObserveInjection var forceRedraw

    var body: some View {
        VStack(spacing: 24) {
            Text("Observed Object")
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
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(Color.white.opacity(0.4))
                .padding(.horizontal,50)
        }
        .padding(30)
        .background(currentColor)
        .foregroundColor(.black)
    }
}

#Preview {
    ContentView()
}
