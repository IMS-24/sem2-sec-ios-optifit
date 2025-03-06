import {Injectable} from "@angular/core";
import {MuscleClient, SearchMuscleDto} from "../../clients/api-client";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class MuscleService {
  private muscleClient: MuscleClient;

  constructor(private readonly httpClient: HttpClient) {
    this.muscleClient = new MuscleClient(this.httpClient, "http://localhost:5154");
  }

  searchMuscles = (search: SearchMuscleDto) => {
    console.log(`[${MuscleService.name}] - searchMuscles`);
    return this.muscleClient.searchMuscles(search);
  }

  // save = (muscle: CreateMuscleDto) => {
  //   console.log(`[${MuscleService.name}] - save: `, muscle);
  //   return this.muscleClient.createMuscle(muscle);
  // }
}
