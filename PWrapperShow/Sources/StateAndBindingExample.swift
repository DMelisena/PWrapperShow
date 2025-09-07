import SwiftUI

struct StateAndBindingExample: View {
    @State private var parentText = "Hello from Parent"
    @State private var isToggled = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("State & Binding Example")
                .font(.title)
                .padding()
            
            // Parent view using @State
            VStack {
                Text("Parent View (@State)")
                    .font(.headline)
                
                TextField("Edit text", text: $parentText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Toggle("Toggle switch", isOn: $isToggled)
                    .padding(.horizontal)
                
                Text("Current text: \(parentText)")
                    .foregroundColor(.blue)
                
                Text("Toggle is: \(isToggled ? "ON" : "OFF")")
                    .foregroundColor(isToggled ? .green : .red)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            Divider()
            
            // Child view using @Binding
            ChildView(text: $parentText, toggle: $isToggled)
        }
        .padding()
    }
}

struct ChildView: View {
    @Binding var text: String
    @Binding var toggle: Bool
    
    var body: some View {
        VStack {
            Text("Child View (@Binding)")
                .font(.headline)
            
            Button("Add exclamation to parent text") {
                text += "!"
            }
            .padding()
            
            Button("Toggle parent switch") {
                toggle.toggle()
            }
            .padding()
            
            Text("Child sees text: \(text)")
                .italic()
            
            Text("Child sees toggle: \(toggle ? "ON" : "OFF")")
                .italic()
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    StateAndBindingExample()
}
