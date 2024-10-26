import {Component, Input, OnInit} from '@angular/core';
import {AsyncPipe} from "@angular/common";
import {PaginatedResultOfWorkoutDto, WorkoutDto} from "../../../clients/api-client";

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

@Component({
  selector: 'qb8-workout-list',
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
  templateUrl: './workout-list.component.html',
  styleUrl: './workout-list.component.css'
})
export class WorkoutListComponent implements OnInit {
  displayedColumns: string[] = ['id', 'description', 'startAtUtc', 'endAtUtc'];
  dataSource: WorkoutDto[] = [];
  @Input({required: true}) workouts$!: Observable<PaginatedResultOfWorkoutDto>;

  constructor() {
    console.log(`[${WorkoutListComponent.name}] - Constructor`);
  }

  ngOnInit() {
    console.log(`[${WorkoutListComponent.name}] - ngOnInit`);
    this.workouts$.subscribe({
      next: (paginatedResult) => {
        this.dataSource = paginatedResult.items || []; // Ensure fallback to empty array if items is undefined
      },
      error: (error) => console.error('Error loading workouts:', error),
    });
  }
}
