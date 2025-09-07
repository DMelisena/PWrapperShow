import SwiftUI

struct StateObjectView: View {
    @StateObject var viewModel = CounterViewModel()
    var body: some View {
        Text("StateObject")
        Text("count =\(viewModel.count)")
        Button("+") {
            viewModel.addCountValue()
        }
    }
}

struct StateObjectMainView: View {
    @State var currentColor: Color = .red
    var body: some View {
        VStack {
            Button("Alternate Main View") {
                if currentColor == .red {
                    currentColor = .blue
                }
                else {
                    currentColor = .red
                }
                
            }
            .padding(30)
            StateObjectView()
        }
        .padding(30)
        .background(currentColor)
        .foregroundColor(.black)
    }
}

class CounterViewModel: ObservableObject {
    @Published var count = 0
    func addCountValue() {
        count += 1
    }
}
