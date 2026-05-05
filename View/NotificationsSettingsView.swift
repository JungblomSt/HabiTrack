
import SwiftUI

struct NotificationsSettingsView: View {
    @AppStorage("selectedTime") private var selectedTime: Date = Date()
    @AppStorage("isActivated") private var isActivated = false
    
    
    var body: some View {
        VStack (spacing: 20) {
            Button("Approve Notifications") {
                NotificationManager.instance.requestNotifications()
                
            }
            Toggle("Activate Notifications", isOn: $isActivated)
                .onChange(of: isActivated) { _, activated in
                    if activated {
                        activateNotifications()
                    } else {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                    
                }
            DatePicker("Time for notification", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .onChange(of: selectedTime) { _, _ in
                    if isActivated {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        activateNotifications()
                    }
                }


        }
        .padding()
    }
    private func activateNotifications() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
        NotificationManager.instance.scheduleNotification(
            title: "HabiTrack",
            body: "Time to make your habit",
            minute: components.minute!,
            hour: components.hour!)
    }
}

#Preview {
    NotificationsSettingsView()
}
