
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
        seeStartHabits()
        
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
            sortBy: [SortDescriptor(\.orderIndex)]
        )
        habits = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func addHabit(title: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newHabit = Habit(title: title, order: habits.count)
                modelContext.insert(newHabit)
        try? modelContext.save()
        fetchHabits()
    }
    
    func validateHabitTitle(_ title: String) -> String? {
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty { return "Title cannot be empty." }
        if trimmed.count > 40 { return "Title cannot be longer than 40 characters." }
        return nil
    }
    
    func toggleCompletion(_ habit: Habit, notificationsViewModel: NotificationsViewModel) {
        habit.toggleCompletionToday()
        if habit.isCompletedToday {
            notificationsViewModel.cancelSingleNotification(for: habit)
        } else if habit.notificationActivated {
            notificationsViewModel.updateNotification(for: habit)
        }
        try? modelContext.save()
        fetchHabits()
    }
    
    func saveHabits() {
        do {
            try modelContext.save()
        } catch {
            print("Save error: \(error)")
        }
    }
    
    func deleteHabit(_ habit: Habit, notificationsViewModel: NotificationsViewModel) {
        notificationsViewModel.cancelSingleNotification(for: habit)
        modelContext.delete(habit)
        try? modelContext.save()
        fetchHabits()
    }
    
    // -- Exempel Habits --
    private func seeStartHabits() {
        guard habits.isEmpty else { return }
        
        let calendar = Calendar.current
        
        let habit1 = Habit(title: "Read", order: 0)
        habit1.notificationActivated = true
        habit1.notificationHour = 21
        habit1.notificationMinute = 0
        for daysAgo in 1...4 {
            if let date = calendar.date(byAdding: .day, value: -daysAgo, to: Date()) {
                habit1.completedDates.append(date)
            }
        }
        
        let habit2 = Habit(title: "Workout", order: 1)
        habit2.notificationActivated = true
        habit2.notificationHour = 7
        habit2.notificationMinute = 30
        for daysAgo in [0, 1, 3, 4, 5] {
            if let date = calendar.date(byAdding: .day, value: -daysAgo, to: Date()) {
                habit2.completedDates.append(date)
            }
        }
        
        let habit3 = Habit(title: "Study to be a marvelous app developer", order: 2)
        habit3.notificationActivated = false
        for daysAgo in [1, 2, 5, 6, 8, 10, 11, 12] {
            if let date = calendar.date(byAdding: .day, value: -daysAgo, to: Date()) {
                habit3.completedDates.append(date)
            }
        }
        
        let habit4 = Habit(title: "Take vitamin pills", order: 3)
        habit4.notificationActivated = true
        habit4.notificationHour = 8
        habit4.notificationMinute = 0
        habit4.toggleCompletionToday()
        
        let habit5 = Habit(title: "Clean", order: 4)
        habit5.notificationActivated = false
        
        for habit in [habit1, habit2, habit3, habit4, habit5] {
            modelContext.insert(habit)
        }
        try? modelContext.save()
        fetchHabits()
    }
}
