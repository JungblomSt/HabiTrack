import SwiftUI
import SwiftData

struct HabitListView: View {
    let viewModel: HabitViewModel
    @State private var showAddHabit = false
    
    var body: some View {
            
            NavigationStack {
                VStack {
                    ProgressBarView()
                    HabitRowView()
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
                }
                .sheet(isPresented: $showAddHabit) {
                    AddHabitView { name in viewModel.addHabit(name: name)
                    }
                }

            } //end NavigationStack

        .environment(viewModel)

    }
    private var dateText: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "d MMM."
        return fmt.string(from: Date())
    }
}




#Preview {
    let container = try! ModelContainer(for: Habit.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let viewModel = HabitViewModel(modelContext: container.mainContext)
    HabitListView(viewModel: viewModel)
        .modelContainer(container)
}
