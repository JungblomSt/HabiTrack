import SwiftUI

struct HabitListView: View {
    @State private var viewModel = HabitViewModel()
    
    
    var body: some View {
        TabView {
            
            NavigationStack {
                HabitRowView()
                    .navigationTitle(Text("Habits"))
            } //end NavigationStack
            .tabItem {
                Label("Habits", systemImage: "list.bullet")
            }
            NavigationStack {
                AddHabitView()
            }
            .tabItem {
                Label("Add", systemImage: "plus")
            }
            
        } //end TabView
        .environment(viewModel)

    }
}

struct HabitRowView: View {
//    @State private var viewModel: HabitViewModel
    @Environment(HabitViewModel.self) private var viewModel
    
    var body: some View {

        List {
            ForEach(viewModel.habits) { habit in
                NavigationLink {
                    HabitDetailView()
//                        habitId: habit.id)
                } label: {
                    HStack {
                        Image(systemName: "checkmark.circle")
//                                item.isCompleted ? "checkmark.circle" : "circle")
//                            .foregroundColor(item.isCompleted ? .green : .red)
                            .frame(width: 36, height: 36)
                            .font(Font.largeTitle)
                            .padding(15)
                            .foregroundStyle(Color.orange)
                            .background(
                                Circle()
                                    .fill(Color.yellow.opacity(0.4))
                                    .stroke(.yellow, lineWidth: 4)
                            )

                        Text(habit.name)
                            .font(.headline)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    HabitListView()
}
