
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
    
    var longestStreak: Int {
        habits.map(\.currentStreak).max() ?? 0
    }
    
    func fetchHabits() {
        let descriptor = FetchDescriptor<Habit>(
            sortBy: [SortDescriptor(\.createdAt)]
        )
        habits = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func addHabit(name: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                let newHabit = Habit(name: name)
                modelContext.insert(newHabit)
        fetchHabits()
    }
    
    func toggleCompletion(_ habit: Habit) {
        habit.toggleCompletionToday()
        fetchHabits()
    }
    
}
