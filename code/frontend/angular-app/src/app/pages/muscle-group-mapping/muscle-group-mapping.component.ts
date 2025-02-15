import {Component} from '@angular/core';
import {GymInputFormComponent} from "../../components/gym/gym-input-form/gym-input-form.component";
import {GymTableViewComponent} from "../../components/gym/gym-table-view/gym-table-view.component";
import {Observable} from "rxjs";
import {PaginatedResultOfMuscleGroupDto} from "../../../clients/api-client";
import {
  MuscleGroupMappingViewComponent
} from "../../components/muscle-group/muscle-group-mapping-view/muscle-group-mapping-view.component";
import {MuscleGroupMappingService} from "../../services/muscle-group-mapping.service";

@Component({
  selector: 'qb8-muscleGroupMapping',
  standalone: true,
  imports: [
    GymInputFormComponent,
    GymTableViewComponent,
    MuscleGroupMappingViewComponent
  ],
  templateUrl: './muscle-group-mapping.component.html',
  styleUrl: './muscle-group-mapping.component.css'
})
export class MuscleGroupMappingComponent {
  public muscleGroupMappings$!: Observable<PaginatedResultOfMuscleGroupDto>;

  constructor(private readonly muscleGroupMappingService: MuscleGroupMappingService) {
  }

  ngOnInit() {
    console.log(`[${MuscleGroupMappingComponent.name}] - ngOnInit`);
    this.muscleGroupMappings$ = this.muscleGroupMappingService.searchMuscleGroupMappings({});
  }
}

