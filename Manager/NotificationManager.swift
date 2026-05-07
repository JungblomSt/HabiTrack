import Foundation
import UserNotifications

class NotificationManager {
    static let instance: NotificationManager = NotificationManager()
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error)")
            } else {
                print("granted: \(granted)")
            }
        }
    }
    
    func scheduleHabitNotification(for habit: Habit) {
        cancelHabitNotification(for: habit)
        
        let content = UNMutableNotificationContent()
        content.title = "Time to \(habit.title)!"
        content.body = "Don't forget to mark it as done!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = habit.notificationHour
        dateComponents.minute = habit.notificationMinute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: habit.notificationIdentifier,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func cancelHabitNotification(for habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [habit.notificationIdentifier]
        )
    }
    
//    not in use at the moment
//    func scheduleGlobalNotification(title: String, body: String, minute: Int, hour: Int) {
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = .default
//        
//        var dateComponents = DateComponents()
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        
//        let request = UNNotificationRequest(
//            identifier: UUID().uuidString,
//            content: content,
//            trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error)")
//            }
//        }
//    }
}
