import SwiftUI

struct HabitRowView: View {
    @Environment(HabitViewModel.self) private var viewModel
    var body: some View {

        List {
            ForEach(viewModel.habits) { habit in
                NavigationLink {
                    HabitDetailView(habit: habit)
                }
                label: {
                    HStack {
                        Button(action: { viewModel.toggleCompletion(habit)}) {
                            Image(systemName: habit.isCompletedToday ? "checkmark.circle" : "circle")
                                .foregroundColor(habit.isCompletedToday ? .green : .secondary)
                                .font(.largeTitle)
                                .padding(10)
                        }
                        .buttonStyle(.plain)

                        Text(habit.name)
                            .font(.headline)
                        
//                        Text("\(habit.completionCount)")
//                            .font(.caption)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .onMove { from, to in
                viewModel.habits.move(fromOffsets: from, toOffset: to)
                for (i, habit) in viewModel.habits.enumerated() {
                    habit.order = i
                }
            }
        }
    }
//    func moveHabit(from: IndexSet, to: Int) {
//        viewModel.habits.move(fromOffsets: from, toOffset: to)
//        for (i, habit) in viewModel.habits.enumerated() {
//            habit.order = i
//        }
//    }

}

