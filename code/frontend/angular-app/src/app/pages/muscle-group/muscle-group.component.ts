import {Component} from '@angular/core';
import {GymInputFormComponent} from "../../components/gym/gym-input-form/gym-input-form.component";
import {GymTableViewComponent} from "../../components/gym/gym-table-view/gym-table-view.component";
import {Observable} from "rxjs";
import {PaginatedResultOfMuscleGroupDto} from "../../../clients/api-client";
import {MuscleGroupService} from "../../services/muscle-group.service";
import {
  MuscleGroupTableViewComponent
} from "../../components/muscle-group/muscle-group-table-view/muscle-group-table-view.component";

@Component({
  selector: 'qb8-muscleGroup',
  standalone: true,
  imports: [
    GymInputFormComponent,
    GymTableViewComponent,
    MuscleGroupTableViewComponent
  ],
  templateUrl: './muscle-group.component.html',
  styleUrl: './muscle-group.component.css'
})
export class MuscleGroupComponent {
  public muscleGroups$!: Observable<PaginatedResultOfMuscleGroupDto>;

  constructor(private readonly muscleGroupService: MuscleGroupService) {
  }

  ngOnInit() {
    console.log(`[${MuscleGroupComponent.name}] - ngOnInit`);
    this.muscleGroups$ = this.muscleGroupService.searchMuscleGroups({});
  }
}

