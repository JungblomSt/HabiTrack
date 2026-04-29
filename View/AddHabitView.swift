
import SwiftUI

struct AddHabitView: View {
    var body: some View {
        VStack {
            Text("Add Habit")
                .font(Font.largeTitle)
                .bold()
                .padding(10)
            TextField("New Habit", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button {

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

#Preview {
    AddHabitView()
}
