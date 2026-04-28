
import Foundation
import Observation

@Observable
class HabitViewModel {
    var habits: [Habit] = [
        Habit(name: "Workout"),
        Habit(name: "Read")
    ]
    
}
