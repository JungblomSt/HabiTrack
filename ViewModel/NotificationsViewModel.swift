import Observation
import UserNotifications
import Foundation
import SwiftData

@Observable
class NotificationsViewModel {
    
    func requestPermission() {
        NotificationManager.instance.requestNotifications()
    }
    
    func updateNotification(for habit: Habit) {
        if habit.notificationActivated {
            NotificationManager.instance.scheduleHabitNotification(for: habit)
        } else {
            NotificationManager.instance.cancel(for: habit)
        }
    }
    
//    not in use yet
//    func setGlobalNotifications(selectedTime: Date) {
//        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
//        NotificationManager.instance.scheduleGlobalNotification(
//            title: "HabiTrack",
//            body: "Time to make your habit",
//            minute: components.minute!,
//            hour: components.hour!)
//    }
    
    func setNotification(for habit: Habit, activated: Bool, hour: Int, minute: Int) {
        habit.notificationActivated = activated
        habit.notificationHour = hour
        habit.notificationMinute = minute
        updateNotification(for: habit)
    }
    
    func reActivateAllNotifications(habits: [Habit]) {
        for habit in habits where habit.notificationActivated{
            NotificationManager.instance.scheduleHabitNotification(for: habit)
        }
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func cancelSingleNotification(for habit: Habit) {
        NotificationManager.instance.cancel(for: habit)
    }
}
