import SwiftUI

struct PropertyWrapperShowcase: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Property Wrapper Showcase")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // AppStorage & SceneStorage Examples
                    AppStorageExample()
                    
                    Divider()
                    
                    // FocusState Example
                    FocusStateExample()
                    
                    Divider()
                    
                    // GestureState Example
                    GestureStateExample()
                    
                    Divider()
                    
                    // SwiftData Examples (Conceptual)
                    SwiftDataConceptExample()
                }
                .padding()
            }
        }
    }
}

struct AppStorageExample: View {
    @AppStorage("username") private var username = "Guest"
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("favoriteNumber") private var favoriteNumber = 42
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("@AppStorage Example")
                .font(.headline)
                .foregroundColor(.blue)
            
            Text("Data persists between app launches")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Username:")
                TextField("Enter username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Toggle("Dark Mode", isOn: $isDarkMode)
            
            HStack {
                Text("Favorite Number:")
                Stepper("\(favoriteNumber)", value: $favoriteNumber, in: 0...100)
            }
            
            Text("Current values - Username: \(username), Dark Mode: \(isDarkMode ? "ON" : "OFF"), Number: \(favoriteNumber)")
                .font(.caption)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
    }
}

struct FocusStateExample: View {
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("@FocusState Example")
                .font(.headline)
                .foregroundColor(.green)
            
            Text("Manages keyboard focus programmatically")
                .font(.caption)
                .foregroundColor(.secondary)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isEmailFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEmailFocused ? Color.blue : Color.clear, lineWidth: 2)
                )
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isPasswordFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isPasswordFocused ? Color.blue : Color.clear, lineWidth: 2)
                )
            
            HStack {
                Button("Focus Email") {
                    isEmailFocused = true
                }
                .buttonStyle(.bordered)
                
                Button("Focus Password") {
                    isPasswordFocused = true
                }
                .buttonStyle(.bordered)
                
                Button("Clear Focus") {
                    isEmailFocused = false
                    isPasswordFocused = false
                }
                .buttonStyle(.bordered)
            }
            
            Text("Email focused: \(isEmailFocused ? "YES" : "NO"), Password focused: \(isPasswordFocused ? "YES" : "NO")")
                .font(.caption)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(12)
    }
}

struct GestureStateExample: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("@GestureState Example")
                .font(.headline)
                .foregroundColor(.purple)
            
            Text("Automatically resets when gesture ends")
                .font(.caption)
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.purple.opacity(0.6))
                .frame(width: 100, height: 100)
                .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            position.width += value.translation.width
                            position.height += value.translation.height
                        }
                )
            
            Text("Drag the rectangle above")
                .font(.caption)
            
            Text("Current drag offset: (\(Int(dragOffset.width)), \(Int(dragOffset.height)))")
                .font(.caption)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Button("Reset Position") {
                withAnimation {
                    position = .zero
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(12)
    }
}

struct SwiftDataConceptExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SwiftData Concepts")
                .font(.headline)
                .foregroundColor(.red)
            
            Text("Modern Core Data replacement (iOS 17+)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    Text("@Model - Marks persistent classes:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("""
                    @Model
                    class Person {
                        var name: String
                        var age: Int
                    }
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                    
                    Text("@Query - Fetches data reactively:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("""
                    @Query var people: [Person]
                    @Query(sort: \\.name) var sorted: [Person]
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                    
                    Text("@Environment(\\.modelContext) - CRUD operations:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("""
                    @Environment(\\.modelContext) var context
                    context.insert(newPerson)
                    try? context.save()
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                }
            }
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    PropertyWrapperShowcase()
}