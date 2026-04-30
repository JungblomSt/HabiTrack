
import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    let onAdd: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Add Habit")
                .font(.largeTitle)
                .bold()
                .padding(10)
            
            TextField("New Habit", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    onAdd(name)
                    dismiss()

            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Start New Habit")
                }
                .foregroundStyle(Color(.white))
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color(.green))
                .cornerRadius(20)
            }
            .padding(.horizontal)
        }
    }
}
