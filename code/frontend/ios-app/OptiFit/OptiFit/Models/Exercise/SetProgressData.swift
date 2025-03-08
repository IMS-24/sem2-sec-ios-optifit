//
//  SetProgressData.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 08.03.25.
//


import SwiftUI
import Charts

struct SetProgressData: Identifiable {
    let id = UUID()
    let setOrder: Int
    let date: Date
    let weight: Double
    let reps: Int
    
    var totalWeight: Double {
        weight * Double(reps)
    }
}
