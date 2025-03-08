//
//  BaseDataManagement.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct BaseDataManagement: View {

    var body: some View {
        NavigationLink("Manage Muscles", destination: MuscleManagementView())
        NavigationLink("Manage Exercise Categories", destination: ExerciseCategoryManagementView())
        NavigationLink("Manage Gyms", destination: GymManagementView())
    }

}

#Preview {
    BaseDataManagement()
}
