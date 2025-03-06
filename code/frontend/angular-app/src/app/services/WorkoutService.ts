import {Injectable} from "@angular/core";
import {CreateWorkoutDto, SearchWorkoutDto, WorkoutClient} from "../../clients/api-client";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class WorkoutService {
  private workoutClient: WorkoutClient;

  constructor(private readonly httpClient: HttpClient) {
    this.workoutClient = new WorkoutClient(this.httpClient, "http://localhost:5154");
  }

  searchWorkouts = (search: SearchWorkoutDto) => {
    console.log(`[${WorkoutService.name}] - searchWorkouts`);
    return this.workoutClient.searchWorkouts(search);

  }
  save = (workout: CreateWorkoutDto) => {
    console.log(`[${WorkoutService.name}] - save: `, workout);
    return this.workoutClient.createWorkout(workout);
  }
}
