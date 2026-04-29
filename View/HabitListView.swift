import SwiftUI

struct HabitListView: View {
    @State private var viewModel = HabitViewModel()
    
    
    var body: some View {
        TabView {
            
            NavigationStack {
                ProgressBarView()
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
                            .font(Font.largeTitle)
                            .padding(10)

                        Text(habit.name)
                            .font(.headline)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct ProgressBarView: View {
//    var viewModel: HabitViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Group {
                HStack {
                    Image (systemName: "checkmark.circle")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.green)
                    VStack (alignment: .center, spacing: 5) {
                        
                        Text ("Today")
                            .font(.caption)
                        Text ("0/1")
                            .font(.title.bold())
                    }
                }
                HStack {
                    Image (systemName: "flame")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.orange)
                    VStack (alignment: .center, spacing: 5){
                        Text ("Total Streak")
                            .font(.caption)
                        Text ("0")
                            .font(Font.title.bold())
                    }
                    
                }

            }
            .padding()
            .background(.background)
            .cornerRadius(10)
            .shadow(radius: 5)
            
        }
        .padding(10)
    }
}

#Preview {
    HabitListView()
}
