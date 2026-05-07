
import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var errorMessage = ""
    let onAdd: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Add Habit")
                .font(.largeTitle)
                .bold()
                .padding(10)
            
            TextField("New Habit", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }
            
            Button {
                if let error = viewModel.validateHabitTitle(title) {
                    errorMessage = error
                    return
                }
                onAdd(title.trimmingCharacters(in: .whitespaces))
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
