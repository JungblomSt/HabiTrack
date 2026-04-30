import SwiftUI

struct HabitListView: View {
    @State private var viewModel = HabitViewModel()
    
    
    var body: some View {
        TabView {
            
            NavigationStack {
                ProgressBarView()
                HabitRowView()
                    .navigationTitle(Text("Habits"))
                    .navigationSubtitle(Text(dateText))
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

private var dateText: String {
    let fmt = DateFormatter()
    fmt.dateFormat = "d MMM."
    return fmt.string(from: Date())
}


#Preview {
    HabitListView()
}
