import SwiftUI




struct WorkoutTrackingHeaderView: View {
    let exerciseCategory: Components.Schemas.GetExerciseCategoryDto
    let gym: Components.Schemas.GetGymDto
    let workoutStartDate: Date
    
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: workoutStartDate)
    }

    
    
    var body: some View {
        // Header: Workout category (motto)
        HStack {
            Text(exerciseCategory.i18NCode!)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(.primaryText))
            Spacer()
        }
        .padding(.horizontal)
        
        // Header: Gym name & city, Start time
        HStack {
            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color(.primaryAccent))
                Text("\(gym.name), \(gym.city)")
                    .font(.subheadline)
                    .foregroundColor(Color(.primaryText))
            }
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "clock")
                    .foregroundColor(Color(.primaryAccent))
                Text(formattedStartTime)
                    .font(.subheadline)
                    .foregroundColor(Color(.primaryText))
            }
        }
        .padding(.horizontal)
    }
}
