//
//  ExerciseWorkoutDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//
import Foundation

struct ExerciseWorkoutDto: Codable, Identifiable, Hashable, Equatable{
    var id: UUID
    
    
    static func ==(lhs: ExerciseWorkoutDto, rhs: ExerciseWorkoutDto) -> Bool {
        lhs.exerciseId == rhs.exerciseId && lhs.workout.id == rhs.workout.id
    }

    
    
    let order: Int
    let workout: GetWorkoutDto
    let exerciseId: UUID
    let workoutSets: [GetWorkoutSetDto]
    let notes: String
}
//public class ExerciseWorkoutDto : BaseDto
//{
//    public int Order { get; set; }
//    public GetWorkoutDto Workout { get; set; } = null!;
//    public Guid ExerciseId { get; set; }
//    public IEnumerable<GetWorkoutSetDto> WorkoutSets { get; set; } = null!;
//    public string Notes { get; set; } = null!;
//}
