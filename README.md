# HabiTrack

A habit tracking app for iOS built with SwiftUI and SwiftData.

## Features

- **Track daily habits** — check off habits each day and build streaks
- **Streak tracking** — see your current streak and longest active streak
- **Progress overview** — visual progress bar showing how many habits you've completed today
- **Reminders** — set daily notifications per habit at a custom time
- **Pause notifications** — pause and resume all notifications at once
- **Reorder habits** — drag and drop habits to reorder them
- **Delete habits** — remove habits with a confirmation alert

## Tech Stack

- SwiftUI
- SwiftData
- UserNotifications
- MVVM architecture
- `@Observable` macro

## Requirements

- iOS 17+
- Xcode 15+

## Project Structure

```text
├── Models
│   └── HabitModel.swift              # SwiftData model
│
├── ViewModels
│   ├── HabitViewModel.swift          # Habit logic and SwiftData operations
│   └── NotificationsViewModel.swift  # Notification state and handling
│
├── Views
│   ├── ContentView.swift             # App entry point
│   ├── MainView.swift                # Navigation and toolbar
│   ├── HabitRowView.swift            # Habit list row
│   ├── HabitDetailView.swift         # Habit detail and settings
│   ├── AddHabitView.swift            # Add new habit sheet
│   └── ProgressBarView.swift         # Today's progress
│
└── Managers
    └── NotificationManager.swift     # UNUserNotificationCenter wrapper
```
