//
//  HabitDetailView.swift
//  HabiTrack
//
//  Created by Stina Thun on 2026-04-28.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    let habit: Habit
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Started habit on: \(habit.createdAt, style: .date)")
                    .font(.subheadline)
                    .foregroundStyle(Color.black.opacity(0.8))
                
//                Text("Compleated: \(habit.compleatedDates.count) times")
//                    .font(.subheadline)
//                    .foregroundStyle(Color.black.opacity(0.8))
                
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

