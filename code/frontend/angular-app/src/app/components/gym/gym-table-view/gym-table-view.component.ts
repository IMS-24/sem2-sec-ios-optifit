import {Component, Input, OnInit} from '@angular/core';
import {PaginatedResultOfGymDto} from "../../../../clients/api-client";
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
import {Observable} from "rxjs";
import {AsyncPipe} from "@angular/common";

@Component({
  selector: 'qb8-gym-table-view',
  standalone: true,
  imports: [
    AsyncPipe,
    MatCell,
    MatCellDef,
    MatColumnDef,
    MatHeaderCell,
    MatHeaderCellDef,
    MatHeaderRow,
    MatHeaderRowDef,
    MatRow,
    MatRowDef,
    MatTable,
  ],
  templateUrl: './gym-table-view.component.html',
  styleUrl: './gym-table-view.component.css'
})
export class GymTableViewComponent implements OnInit {
  displayedColumns: string[] = ['id', 'name', 'address', 'city', 'zipCode'];
  @Input({required: true}) gyms$!: Observable<PaginatedResultOfGymDto>;

  constructor() {
    console.log(`[${GymTableViewComponent.name}] - Constructor`);
  }

  ngOnInit() {
    console.log(`[${GymTableViewComponent.name}] - ngOnInit`);
  }
}
