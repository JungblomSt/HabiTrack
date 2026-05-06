//


// not in use at the moment



//import SwiftUI
//
//struct NotificationsSettingsView: View {
//    @Environment(HabitViewModel.self) private var habitViewModel
//    @Environment(NotificationsViewModel.self) private var notificationsViewModel
//    @AppStorage("isActivated") private var isActivated = false
//    
//    
//    var body: some View {
//        VStack (spacing: 20) {
//            Button("Approve Notifications") {
//                viewModel.requestPermission()
//                
//            }
//            Toggle("Activate Notifications", isOn: $isActivated)
//                .onChange(of: isActivated) { _, activated in
//                    if activated {
//                        notificationsViewModel.reActivateAllNotifications(habits: habitViewModel.habits)
//                    } else {
//                        notificationsViewModel.cancelNotifications()
//                    }
//                }
//            DatePicker("Time for notification", selection: $selectedTime, displayedComponents: .hourAndMinute)
//                .onChange(of: selectedTime) { _, _ in
//                    if isActivated {
//                        viewModel.cancelNotifications()
//                        viewModel.setGlobalNotifications(selectedTime: selectedTime)
//                    }
//                }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    NotificationsSettingsView()
//}
