import {Component} from '@angular/core';
import {GymInputFormComponent} from "../../components/gym/gym-input-form/gym-input-form.component";
import {GymTableViewComponent} from "../../components/gym/gym-table-view/gym-table-view.component";
import {Observable} from "rxjs";
import {PaginatedResultOfMuscleDto} from "../../../clients/api-client";
import {MuscleService} from "../../services/muscle.service";
import {MuscleTableViewComponent} from "../../components/muscle-table-view/muscle-table-view.component";

@Component({
  selector: 'qb8-muscle',
  standalone: true,
  imports: [
    GymInputFormComponent,
    GymTableViewComponent,
    MuscleTableViewComponent
  ],
  templateUrl: './muscle.component.html',
  styleUrl: './muscle.component.css'
})
export class MuscleComponent {
  public muscles$!: Observable<PaginatedResultOfMuscleDto>;

  constructor(private readonly muscleService: MuscleService) {
  }

  ngOnInit() {
    console.log(`[${MuscleComponent.name}] - ngOnInit`);
    this.muscles$ = this.muscleService.searchMuscles({});
  }
}
