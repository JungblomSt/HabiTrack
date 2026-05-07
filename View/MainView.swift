import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.scenePhase) private var scenePhase
    let viewModel: HabitViewModel
    @Environment(NotificationsViewModel.self) private var notificationsViewModel
    @State private var showAddHabit = false
    @State private var today = Date()
    @AppStorage("notificationsPaused") private var notificationsPaused = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ProgressBarView()
                HabitRowView(today: today)
            }
            .navigationTitle("Habits")
            .navigationSubtitle(Text(dateText))
            .toolbar {
                // -- Add Habit --
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                // -- All Notifications --
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        notificationsPaused.toggle()
                        if notificationsPaused {
                            notificationsViewModel.cancelNotifications()
                        } else {
                            notificationsViewModel.reActivateAllNotifications(habits: viewModel.habits)
                        }
                    } label: {
                        Image(systemName: notificationsPaused ? "bell.slash.circle" : "bell.circle")
                            .font(.title)
                            .foregroundStyle(notificationsPaused ? Color.secondary : Color.primary)
                    }
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView { title in viewModel.addHabit(title: title)
                }
            }
            
        } //end NavigationStack
        
        // -- Uppdate Notifications UI--
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                today = Date()
                for habit in viewModel.habits {
                    if habit.isCompletedToday {
                        notificationsViewModel.cancelSingleNotification(for: habit)
                    } else if habit.notificationActivated && !notificationsPaused{
                        notificationsViewModel.updateNotification(for: habit)
                    }
                }
            }
        }
        .environment(viewModel)
        .onAppear {
            notificationsViewModel.requestPermission()
        }
        
    }
    private var dateText: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "d MMM."
        return fmt.string(from: today)
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Habit.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let viewModel = HabitViewModel(modelContext: container.mainContext)
    
    return MainView(viewModel: viewModel)
        .environment(NotificationsViewModel())
        .modelContainer(container)
}
