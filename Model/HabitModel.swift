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


