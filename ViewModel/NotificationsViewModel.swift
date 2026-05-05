import Observation
import UserNotifications
import Foundation
import SwiftData

@Observable
class NotificationsViewModel {
    
    func requestPermission() {
        NotificationManager.instance.requestNotifications()
    }
    
    func activateNotifications(selectedTime: Date) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
        NotificationManager.instance.scheduleNotification(
            title: "HabiTrack",
            body: "Time to make your habit",
            minute: components.minute!,
            hour: components.hour!)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
