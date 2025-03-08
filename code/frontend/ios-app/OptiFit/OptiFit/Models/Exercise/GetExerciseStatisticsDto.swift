//
//  GetExerciseStatisticsDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//


//
//  GetExerciseStatisticsDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//
import Foundation

struct GetExerciseStatisticsDto: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let exerciseDto: GetExerciseDto
    let exerciseWorkoutsDto: [ExerciseWorkoutDto]
}
