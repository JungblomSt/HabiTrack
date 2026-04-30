
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: HabitViewModel?

    var body: some View {
        Group {
            if let vm = viewModel {
                HabitListView(viewModel: vm)
            } else {
                ProgressView()
                    .onAppear { viewModel = HabitViewModel(modelContext: modelContext) }
            }
        }
    }
}

#Preview {
    ContentView()
}
