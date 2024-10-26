import {Component, inject} from '@angular/core';
import {FormBuilder, FormsModule, ReactiveFormsModule, Validators} from "@angular/forms";
import {MatButton} from "@angular/material/button";
import {MatFormField, MatLabel} from "@angular/material/form-field";
import {MatInput} from "@angular/material/input";
import {FormActionsComponentComponent} from "../common/form-actions-component/form-actions-component.component";

@Component({
  selector: 'qb8-workout-input-form',
  standalone: true,
  imports: [
    FormsModule,
    MatButton,
    MatFormField,
    MatInput,
    MatLabel,
    ReactiveFormsModule,
    FormActionsComponentComponent
  ],
  templateUrl: './workout-input-form.component.html',
  styleUrl: './workout-input-form.component.css'
})
export class WorkoutInputFormComponent {

  private formBuilder = inject(FormBuilder);
  workoutInputForm = this.formBuilder.group({
    description: ['', [Validators.required, Validators.max(500)]],
    startTime: ['', [Validators.required, Validators.maxLength(666)]],
    endTime: ['', [Validators.required, Validators.maxLength(5000)]],
    notes: ['', [Validators.required, Validators.maxLength(200)]],
    gymId: ['', [Validators.required]],
  })
  onCancel = (event: Event) => {
    event.preventDefault();
    console.log(`[${WorkoutInputFormComponent.name}] - onCancel`);
    this.workoutInputForm.reset();
  }

  onSave = (event: Event) => {
    event.preventDefault();
    console.log(`[${WorkoutInputFormComponent.name}] - save`, this.workoutInputForm.value);

  }
}
