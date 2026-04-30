import Foundation
import SwiftData

@Model
class Habit: Identifiable{
    var id: UUID
    var name: String
    var createdAt: Date
    var completedDates: [Date] = []
    
    init(
        name: String
    ) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
        self.completedDates = []
    }
    
    var isCompletedToday: Bool {
        let calendar = Calendar.current
        return completedDates.contains { date in
            calendar.isDateInToday(date)
        }
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

