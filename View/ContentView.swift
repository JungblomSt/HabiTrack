
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: HabitViewModel?
    @State private var notificationsViewModel = NotificationsViewModel()

    var body: some View {
        Group {
            if let vm = viewModel {
                MainView(viewModel: vm)
                    .environment(notificationsViewModel)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel = HabitViewModel(modelContext: modelContext)
                    }
            }
        }
    }
}

