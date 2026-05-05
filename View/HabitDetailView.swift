//
//  HabitDetailView.swift
//  HabiTrack
//
//  Created by Stina Thun on 2026-04-28.
//

import SwiftUI
import SwiftData //for preview

struct HabitDetailView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    let habit: Habit
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Started habit on: \(habit.createdAt, style: .date)")
                    .padding(20)

                Text("Sense then, you have done it \(habit.completedDates.count) times")
                    .padding(20)
                
                MultiDatePicker(
                    "Completed dates",
                    selection: Binding(
                        get: {
                            Set(habit.completedDates.map {
                                Calendar.current.startOfDay(for: $0)
                            }.compactMap {
                                Calendar.current.dateComponents([.calendar, .year, .month, .day], from: $0)
                            })
                        },
                        set: { _ in }
                    )
                )
                .disabled(true)
                
                Button() {
                    viewModel.deleteHabit(habit)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Radera vana")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
        .navigationTitle(habit.name)
    }
}
#Preview {
    let container = try! ModelContainer(
        for: Habit.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let viewModel = HabitViewModel(modelContext: container.mainContext)
    let habit = Habit(name: "Läsa")
    container.mainContext.insert(habit)
    
    return NavigationStack {
        HabitDetailView(habit: habit)
    }
    .environment(viewModel)
    .modelContainer(container)
}

