import {Component, OnInit} from '@angular/core';
import {WorkoutListComponent} from "../../components/workout-list/workout-list.component";
import {WorkoutService} from "../../services/WorkoutService";
import {PaginatedResultOfWorkoutDto} from "../../../clients/api-client";
import {Observable} from "rxjs";
import {WorkoutInputFormComponent} from "../../components/workout-input-form/workout-input-form.component";

@Component({
  selector: 'qb8-workout',
  standalone: true,
  imports: [
    WorkoutListComponent,
    WorkoutInputFormComponent
  ],
  templateUrl: './workout.component.html',
  styleUrl: './workout.component.css'
})
export class WorkoutComponent implements OnInit {
  workouts$!: Observable<PaginatedResultOfWorkoutDto>;

  constructor(private workoutService: WorkoutService) {
    console.log(`[${WorkoutComponent.name}] - Constructor`);
  }

  ngOnInit() {
    console.log(`[${WorkoutComponent.name}] - ngOnInit`);
    this.workouts$ = this.workoutService.searchWorkouts({});
  }
}
