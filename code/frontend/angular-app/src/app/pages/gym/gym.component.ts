import {Component, OnInit} from '@angular/core';
import {GymInputFormComponent} from "../../components/gym/gym-input-form/gym-input-form.component";
import {GymTableViewComponent} from "../../components/gym/gym-table-view/gym-table-view.component";
import {GymService} from "../../services/GymService";
import {PaginatedResultOfGymDto} from "../../../clients/api-client";
import {Observable} from "rxjs";

@Component({
  selector: 'qb8-gym',
  standalone: true,
  imports: [
    GymInputFormComponent,
    GymTableViewComponent
  ],
  templateUrl: './gym.component.html',
  styleUrl: './gym.component.css'
})
export class GymComponent implements OnInit {
  public gyms$!: Observable<PaginatedResultOfGymDto>;

  constructor(private readonly gymService: GymService) {
  }

  ngOnInit() {
    console.log(`[${GymComponent.name}] - ngOnInit`);
    this.gyms$ = this.gymService.searchGyms({});
  }
}
