import {Injectable} from "@angular/core";
import {MuscleGroupClient, SearchMuscleGroupDto} from "../../clients/api-client";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class MuscleGroupService {
  private muscleGroupClient: MuscleGroupClient;

  constructor(private readonly httpClient: HttpClient) {
    this.muscleGroupClient = new MuscleGroupClient(this.httpClient, "http://localhost:5154");
  }

  searchMuscleGroups = (search: SearchMuscleGroupDto) => {
    console.log(`[${MuscleGroupService.name}] - searchMuscleGroups`);
    return this.muscleGroupClient.searchMuscleGroups(search);
  }

  // save = (muscleGroup: CreateMuscleGroupDto) => {
  //   console.log(`[${MuscleGroupService.name}] - save: `, muscleGroup);
  //   return this.muscleGroupClient.createMuscleGroup(muscleGroup);
  // }
}
