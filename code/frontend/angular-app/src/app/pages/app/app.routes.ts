import {Routes} from '@angular/router';
import {GymComponent} from "../gym/gym.component";
import {HomeComponent} from "../home/home.component";
import {WorkoutComponent} from "../workout/workout.component";


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
    path: "", redirectTo: "/home", pathMatch: "full"
  }
];
