import {Injectable} from "@angular/core";
import {MuscleGroupMappingClient, SearchMuscleGroupDto} from "../../clients/api-client";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class MuscleGroupMappingService {
  private muscleGroupMappingClient: MuscleGroupMappingClient;

  constructor(private readonly httpClient: HttpClient) {
    this.muscleGroupMappingClient = new MuscleGroupMappingClient(this.httpClient, "http://localhost:5154");
  }

  searchMuscleGroupMappings = (search: SearchMuscleGroupDto) => {
    console.log(`[${MuscleGroupMappingService.name}] - searchMuscleGroupMappings`);
    return this.muscleGroupMappingClient.searchMuscleGroupMappings(search);
  }

  // save = (muscleGroupMapping: CreateMuscleGroupDto) => {
  //   console.log(`[${MuscleGroupService.name}] - save: `, muscleGroupMapping);
  //   return this.muscleGroupMappingClient.createMuscleGroup(muscleGroupMapping);
  // }
}
