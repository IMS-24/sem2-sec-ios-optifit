//
//  CreateWorkoutSetDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//
import Foundation
struct CreateWorkoutSetDto:Codable,Identifiable{
    var id: UUID?
    var order: Int?
    var reps: Int?
    var weight: Double?
}

/*
 public int Order { get; set; }
 public int Reps { get; set; }
 public decimal Weight { get; set; }
 */
