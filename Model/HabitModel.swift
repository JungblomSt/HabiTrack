import Foundation
import SwiftData

@Model
class Habit: Identifiable{
    var id: UUID
    var name: String
    var createdAt: Date
    var completedDates: [Date]
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
        self.completedDates = []
    }
    
    var currentStreak: Int {
        let calendar = Calendar.current
        var streak: Int = 0
        var currentDate = Date()
        
        if !isCompletedToday {
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
        }
        while true {
            let completed = completedDates.contains { calendar.isDate($0, inSameDayAs: currentDate) }
            if !completed {
                break
            }
            streak += 1
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            
        }
        return streak
    }
    
    var isCompletedToday: Bool {
        let calendar = Calendar.current
        return completedDates.contains { calendar.isDateInToday($0)}
    }
    
    func toggleCompletionToday() {
        let calendar = Calendar.current
        if isCompletedToday {
            completedDates.removeAll { calendar.isDateInToday($0) }
        } else {
            completedDates.append(Date())
        }
    }
}


