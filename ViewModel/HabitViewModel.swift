
import Foundation
import SwiftData
import Observation

@Observable
class HabitViewModel {
    var habits: [Habit] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchHabits()
        
    }
    var completedTodayCount: Int {
        habits.filter(\.isCompletedToday).count
    }
    
    var longestStreak: Int {
        habits.map(\.currentStreak).max() ?? 0
    }
    
    var progressToday: Double {
        guard !habits.isEmpty else { return 0 }
        let totalCount = Double(habits.count)
        let completedCount = Double(completedTodayCount)
        return completedCount / totalCount
    }
    
    func fetchHabits() {
        let descriptor = FetchDescriptor<Habit>(
            sortBy: [SortDescriptor(\.order)]
        )
        habits = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func addHabit(name: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newHabit = Habit(name: name, order: habits.count)
                modelContext.insert(newHabit)
        try? modelContext.save()
        fetchHabits()
    }
    
    func toggleCompletion(_ habit: Habit) {
        habit.toggleCompletionToday()
        try? modelContext.save()
        fetchHabits()
    }
    
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        try? modelContext.save()
        fetchHabits()
    }
    
    
}
