import {Component, Input} from '@angular/core';
import {Observable} from "rxjs";
import {PaginatedResultOfMuscleDto} from "../../../clients/api-client";
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
  selector: 'qb8-muscle-table-view',
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
  templateUrl: './muscle-table-view.component.html',
  styleUrl: './muscle-table-view.component.css'
})
export class MuscleTableViewComponent {
  displayedColumns: string[] = ['id', 'i18NCode'];
  @Input({required: true}) muscles$!: Observable<PaginatedResultOfMuscleDto>;

  constructor() {
    console.log(`[${MuscleTableViewComponent.name}] - Constructor`);
  }

  ngOnInit() {
    console.log(`[${MuscleTableViewComponent.name}] - ngOnInit`);
  }
}
