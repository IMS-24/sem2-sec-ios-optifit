import {Component, Input, OnInit} from '@angular/core';
import {Observable} from "rxjs";
import {PaginatedResultOfMuscleDto} from "../../../../clients/api-client";
import {AsyncPipe} from "@angular/common";
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
  selector: 'qb8-muscle-group-table-view',
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
    MatHeaderCellDef
  ],
  templateUrl: './muscle-group-table-view.component.html',
  styleUrl: './muscle-group-table-view.component.css'
})
export class MuscleGroupTableViewComponent implements OnInit {
  displayedColumns: string[] = ['id', 'i18NCode'];
  @Input({required: true}) muscleGroups$!: Observable<PaginatedResultOfMuscleDto>;

  constructor() {
    console.log(`[${MuscleGroupTableViewComponent.name}] - Constructor`);
  }

  ngOnInit() {
    console.log(`[${MuscleGroupTableViewComponent.name}] - ngOnInit`);
  }
}
