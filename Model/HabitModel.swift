import Foundation
import SwiftData

@Model
class Habit: Identifiable{
    var id: UUID
    var title: String
    var createdAt: Date
    var completedDates: [Date]
    var orderIndex: Int
    var notificationActivated: Bool
    var notificationHour: Int
    var notificationMinute: Int
    
    init(title: String, order: Int = 0) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
        self.completedDates = []
        self.orderIndex = order
        self.notificationActivated = false
        self.notificationHour = 8
        self.notificationMinute = 0
    }
    
    var notificationIdentifier: String {
        "habit-\(id.uuidString)"
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
            guard let newDate = calendar.date(byAdding: .day, value: -1, to: currentDate) else { break }
            currentDate = newDate
            
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


