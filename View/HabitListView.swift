import SwiftUI
import SwiftData

struct HabitListView: View {
    @Environment(\.scenePhase) private var scenePhase
    let viewModel: HabitViewModel
    @State private var showNotificationsSettings = false
    @State private var showAddHabit = false
    @State private var today = Date()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ProgressBarView()
                HabitRowView(today: today)
            }
            .navigationTitle("Habits")
            .navigationSubtitle(Text(dateText))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showNotificationsSettings = true
                    } label: {
                        Image(systemName: "bell.and.waves.left.and.right")
                    }
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView { name in viewModel.addHabit(name: name)
                }
            }
            .sheet(isPresented: $showNotificationsSettings) {
                NotificationsSettingsView()
            }
            
        } //end NavigationStack
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                today = Date()
            }
        }
        .environment(viewModel)
        
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
    
    viewModel.addHabit(name: "Jump")
    viewModel.addHabit(name: "Run")
    viewModel.addHabit(name: "Read")
    
    return HabitListView(viewModel: viewModel)
        .modelContainer(container)
}
