import SwiftUI

struct HabitRowView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @Environment(NotificationsViewModel.self) private var notificationsViewModel: NotificationsViewModel
    @AppStorage("notificationsPaused") private var notificationsPaused = false
    let today: Date
    var body: some View {
        
        List {
            ForEach(viewModel.habits) { habit in
                NavigationLink {
                    HabitDetailView(habit: habit)
                }
                label: {
                    HStack {
                        Button(action: { viewModel.toggleCompletion(habit, notificationsViewModel: notificationsViewModel)}) {
                            Image(systemName: habit.isCompletedToday ? "checkmark.circle" : "circle")
                                .foregroundColor(habit.isCompletedToday ? .green : .secondary)
                                .font(.largeTitle)
                                .padding(10)
                        }
                        .buttonStyle(.plain)
                        
                        Text(habit.title)
                            .font(.headline)
                        Spacer()
                        
                        HStack {
                            if habit.notificationActivated && !notificationsPaused{
                                Image(systemName: "bell.fill")
                                Text(String(format: "%02d:%02d", habit.notificationHour, habit.notificationMinute))
                            } else if habit.notificationActivated && notificationsPaused {
                                Image(systemName: "bell.slash.fill")
                                    .foregroundStyle(Color.secondary)
                            }
                            
                            Image(systemName: "flame")
                                .foregroundStyle(Color(.orange))
                            Text("\(habit.currentStreak)")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .onMove { from, to in
                viewModel.habits.move(fromOffsets: from, toOffset: to)
                for (i, habit) in viewModel.habits.enumerated() {
                    habit.orderIndex = i
                }
                viewModel.saveHabits()
            }
        }
    }
}
