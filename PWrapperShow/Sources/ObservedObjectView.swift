import SwiftUI

struct ObservedObjectView: View {
    @ObservedObject var viewModel = CounterViewModel()
    var body: some View {
        Text("Observed Object")
        Text("count =\(viewModel.count)")
        Button("+") {
            viewModel.addCountValue()
        }
    }
}

struct ObservedMainView: View {
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
            ObservedObjectView()
        }
        .padding(30)
        .background(currentColor)
        .foregroundColor(.black)
    }
}

