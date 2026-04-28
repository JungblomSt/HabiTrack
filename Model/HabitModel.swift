import Foundation

class Habit: Identifiable{
    var id: UUID
    var name: String
    var createdAt: Date
    var completions: [HabitCompletion]
    
    init(
        name: String
    ) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
        self.completions = []
    }
    
}
class HabitCompletion {
    var id: UUID
    var date: Date
    var habit: Habit?
 
    init(date: Date = Date()) {
        self.id = UUID()
        self.date = date
    }
}
//extension Habit {
//    static var habits: [Habit] = [
//        Habit(name: Springa)
//        Habit(name: Läsa)
//        Habit(name: Vila)
//    ]
//}
