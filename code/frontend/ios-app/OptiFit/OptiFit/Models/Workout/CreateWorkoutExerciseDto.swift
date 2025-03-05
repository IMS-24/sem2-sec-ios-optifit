//
//  CreateWorkoutExerciseDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//
import Foundation

struct CreateWorkoutExerciseDto:Codable,Identifiable{
    var id:UUID?
    var order:Int
    var exerciseId:UUID
    var notes:String?
    var workoutSets:[CreateWorkoutSetDto]
}
/*
 public int Order { get; set; }
 public Guid ExerciseId { get; set; }
 public string Notes { get; set; } = null!;
 public IList<CreateWorkoutSetDto> WorkoutSets { get; set; } = new List<CreateWorkoutSetDto>();
 */
