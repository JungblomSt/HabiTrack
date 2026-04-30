
import SwiftUI

struct ProgressBarView: View {
    @Environment(HabitViewModel.self) private var viewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Group {
                HStack {
                    Image (systemName: "checkmark.circle")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.green)
                    VStack (alignment: .center, spacing: 5) {
                        
                        Text ("Today")
                            .font(.caption)
                        Text ("0/1")
                            .font(.title.bold())
                    }
                }
                HStack {
                    Image (systemName: "flame")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.orange)
                    VStack (alignment: .center, spacing: 5){
                        Text ("Longest Streak")
                            .font(.caption)
                        Text ("0")
                            .font(Font.title.bold())
                    }
                    
                }

            }
            .padding()
            .background(.background)
            .cornerRadius(10)
            .shadow(radius: 5)
            
        }
        .padding(10)
    }
}
#Preview {
    ProgressBarView()
        .environment(HabitViewModel())
}
