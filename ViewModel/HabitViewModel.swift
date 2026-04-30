
import Foundation
import SwiftData
import Observation

@Observable
class HabitViewModel {
    var habits: [Habit] = [
            Habit(name: "Workout"),
            Habit(name: "Read") ]
//    private var modelContext: ModelContext
//    
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        fetchHabits()
//        
//    }
//    
//    func fetchHabits() {
//        let descriptor = FetchDescriptor<Habit>(
//            sortBy: [SortDescriptor(\.createdAt)]
//        )
//        habits = (try? modelContext.fetch(descriptor)) ?? []
//    }
    
}
