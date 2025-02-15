import {Component, Input, OnInit} from '@angular/core';
import {Observable} from "rxjs";
import {PaginatedResultOfMuscleGroupMappingDto} from "../../../../clients/api-client";
import {AsyncPipe, JsonPipe} from "@angular/common";
import {
  MatCell,
  MatCellDef,
  MatColumnDef,
  MatHeaderCell,
  MatHeaderCellDef,
  MatHeaderRow,
  MatHeaderRowDef,
  MatRow,
  MatRowDef,
  MatTable
} from "@angular/material/table";

@Component({
  selector: 'qb8-muscle-group-mapping-view',
  standalone: true,
  imports: [
    AsyncPipe,
    MatCell,
    MatCellDef,
    MatColumnDef,
    MatHeaderCell,
    MatHeaderRow,
    MatHeaderRowDef,
    MatRow,
    MatRowDef,
    MatTable,
    MatHeaderCellDef,
    JsonPipe
  ],
  templateUrl: './muscle-group-mapping-view.component.html',
  styleUrl: './muscle-group-mapping-view.component.css'
})
export class MuscleGroupMappingViewComponent implements OnInit {
  displayedColumns: string[] = ['id', 'muscleGroupId', 'muscleId'];
  @Input({required: true}) muscleGroupMappings$!: Observable<PaginatedResultOfMuscleGroupMappingDto>;

  constructor() {
    console.log(`[${MuscleGroupMappingViewComponent.name}] - Constructor`);
  }

  ngOnInit() {
    console.log(`[${MuscleGroupMappingViewComponent.name}] - ngOnInit`);
  }
}
