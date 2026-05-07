
import SwiftUI
import SwiftData //for preview

struct HabitDetailView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @Environment(NotificationsViewModel.self) private var notificationViewModel
    @Environment(\.dismiss) var dismiss
    let habit: Habit
    
    @State private var notificationActivated: Bool = false
    @State private var selectedTime: Date = Date()
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text("Started habit on: \(habit.createdAt, style: .date)")
                    .font(.subheadline)
                    .padding(5)
                
                Text("Sense then, you have done it \(habit.completedDates.count) times")
                    .font(.subheadline)
                
                // MARK: -- Calendar --
                MultiDatePicker(
                    "Completed dates",
                    selection: Binding(
                        get: {
                            Set(habit.completedDates.map {
                                Calendar.current.startOfDay(for: $0)
                            }.compactMap {
                                Calendar.current.dateComponents([.calendar, .year, .month, .day], from: $0)
                            })
                        },
                        set: { _ in }
                    )
                )
                
                Divider()
                
                // MARK: -- Notifications --
                HStack(spacing: 12) {
                    Toggle("Reminder", isOn: $notificationActivated)
                        .onChange(of: notificationActivated) { _, activated in
                            saveNotification(activated: activated)
                        }
                    
                    if notificationActivated {
                        DatePicker(
                            "Time",
                            selection: $selectedTime,
                            displayedComponents: .hourAndMinute
                        )
                        .onChange(of: selectedTime) { _, _ in
                            saveNotification(activated: true)
                        }
                    }
                }
                .padding(.horizontal)
                
                // MARK: -- Delete Habit --
                Button() {
                    showDeleteAlert = true

                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Radera vana")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
        .navigationTitle(habit.title)
        .alert("Delete Habit", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.deleteHabit(habit, notificationsViewModel: notificationViewModel)
                DispatchQueue.main.async {
                    dismiss()
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you certain you want to delete \(habit.title) and al your progress? This cannot be undone.")
        }
        .onAppear {
            notificationActivated = habit.notificationActivated
            var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            components.hour = habit.notificationHour
            components.minute = habit.notificationMinute
            selectedTime = Calendar.current.date(from: components) ?? Date()
        }
    }
    private func saveNotification(activated: Bool) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
        notificationViewModel.setNotification(
            for: habit,
            activated: activated,
            hour: components.hour ?? 8,
            minute: components.minute ?? 0
        )
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Habit.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let viewModel = HabitViewModel(modelContext: container.mainContext)
    let notificationsViewModel = NotificationsViewModel()
    let habit = Habit(title: "Read")
    container.mainContext.insert(habit)
    
    return NavigationStack {
        HabitDetailView(habit: habit)
    }
    .environment(viewModel)
    .environment(notificationsViewModel)
    .modelContainer(container)
}

