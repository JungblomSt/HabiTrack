
import SwiftUI
import SwiftData

struct ProgressBarView: View {
    @Environment(HabitViewModel.self) private var viewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Group {
                // -- Progress Today Card --
                HStack {
                    Spacer()
                    CircularProgressView(progress: viewModel.progressToday)
                    Spacer()
                    VStack (alignment: .center, spacing: 5) {
                        
                        Text ("Today")
                            .font(.caption)
                        Text ("\(viewModel.completedTodayCount)/\(viewModel.habits.count)")
                            .font(.title.bold())
                    }
                    Spacer()
                }
                // -- Longest Active Streak Card --
                HStack {
                    Spacer()
                    Image (systemName: "flame.fill")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.orange)
                    VStack (alignment: .center, spacing: 5){
                        Text ("Streak")
                            .font(.caption)
                        Text ("\(viewModel.longestStreak)")
                            .font(Font.title.bold())
                    }
                    Spacer()
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
struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        if progress == 0 {
            Image (systemName: "circle")
                .font(.largeTitle.bold())
                .foregroundColor(Color.secondary)
        } else if progress == 1 {
            Image (systemName: "checkmark.circle")
                .font(.largeTitle.bold())
                .foregroundColor(Color.green)
        } else {
            Circle()
            .trim(from: 0, to: progress)
            .stroke(Color.green, style: StrokeStyle(lineWidth: 5, lineCap: .round))
            .rotationEffect(.degrees(-90))
            .frame(width: 30, height: 30)
        }


    }
    
}

#Preview {
    let container = try! ModelContainer(
        for: Habit.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let viewModel = HabitViewModel(modelContext: container.mainContext)
    
    return ProgressBarView()
        .environment(viewModel)
        .modelContainer(container)
}
