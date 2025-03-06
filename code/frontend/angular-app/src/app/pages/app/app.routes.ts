import {Routes} from '@angular/router';
import {GymComponent} from "../gym/gym.component";
import {HomeComponent} from "../home/home.component";
import {WorkoutComponent} from "../workout/workout.component";
import {MuscleComponent} from "../muscle/muscle.component";
import {MuscleGroupComponent} from "../muscle-group/muscle-group.component";
import {MuscleGroupMappingComponent} from "../muscle-group-mapping/muscle-group-mapping.component";


export const routes: Routes = [
  {
    path: "gym", component: GymComponent
  },
  {
    path: "home", component: HomeComponent
  },
  {
    path: "workout", component: WorkoutComponent
  },
  {
    path: "muscle", component: MuscleComponent
  },
  {
    path: "muscle-group", component: MuscleGroupComponent
  },
  {
    path: "muscle-group-mapping", component: MuscleGroupMappingComponent
  },
  {
    path: "", redirectTo: "/home", pathMatch: "full"
  }
];
