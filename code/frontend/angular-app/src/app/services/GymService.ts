import {Injectable} from "@angular/core";
import {CreateGymDto, GymClient, SearchGymsDto} from "../../clients/api-client";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class GymService {
  private gymClient: GymClient;

  constructor(private readonly httpClient: HttpClient) {
    this.gymClient = new GymClient(this.httpClient, "http://localhost:5154");
  }

  searchGyms = (search: SearchGymsDto) => {
    console.log(`[${GymService.name}] - searchGyms`);
    return this.gymClient.searchGyms(search);
  }

  save = (gym: CreateGymDto) => {
    console.log(`[${GymService.name}] - save: `, gym);
    return this.gymClient.createGym(gym);
  }
}
