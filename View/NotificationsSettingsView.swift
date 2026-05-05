
import SwiftUI

struct NotificationsSettingsView: View {
    let viewModel = NotificationsViewModel()
    @AppStorage("selectedTime") private var selectedTime: Date = Date()
    @AppStorage("isActivated") private var isActivated = false
    
    
    var body: some View {
        VStack (spacing: 20) {
            Button("Approve Notifications") {
                viewModel.requestPermission()
                
            }
            Toggle("Activate Notifications", isOn: $isActivated)
                .onChange(of: isActivated) { _, activated in
                    if activated {
                        viewModel.activateNotifications(selectedTime: selectedTime)
                    } else {
                        viewModel.cancelNotifications()
                    }
                }
            DatePicker("Time for notification", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .onChange(of: selectedTime) { _, _ in
                    if isActivated {
                        viewModel.cancelNotifications()
                        viewModel.activateNotifications(selectedTime: selectedTime)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    NotificationsSettingsView()
}
