//
//  CreateWorkoutDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 02.03.25.
//
import Foundation
//struct CreateWorkoutDto : Codable{
//    let description: String?
//    let StartAtUtc: Date
//    let EndAtUtc: Date?
//    let Notes: String?
//    let GymId: UUID?
//}

struct CreateWorkoutDto: Codable {
    let description: String
    let startAtUtc: Date
    let endAtUtc: Date
    let notes: String
    let gymId: UUID
    let workoutExercises: [CreateWorkoutExerciseDto]
}
/*
 
 public class CreateWorkoutDto
 {
 public string? Description { get; set; } = null!;
 public Guid UserId { get; set; }
 public DateTime StartAtUtc { get; set; }
 public DateTime? EndAtUtc { get; set; }
 public string? Notes { get; set; } = null!;
 public Guid GymId { get; set; }
 }
 */
