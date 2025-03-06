import {Component, inject} from '@angular/core';
import {FormBuilder, ReactiveFormsModule, Validators} from "@angular/forms";
import {MatFormField, MatInput, MatLabel} from "@angular/material/input";
import {FormActionsComponentComponent} from "../../common/form-actions-component/form-actions-component.component";

@Component({
  selector: 'qb8-workout-log-form',
  standalone: true,
  imports: [
    MatInput,
    ReactiveFormsModule,
    MatLabel,
    MatFormField,
    FormActionsComponentComponent
  ],
  templateUrl: './workout-log-form.component.html',
  styleUrl: './workout-log-form.component.css'
})
export class WorkoutLogFormComponent {

  private formBuilder = inject(FormBuilder);
  workoutLogForm = this.formBuilder.group({
    order: ['', [Validators.required, Validators.max(666)]],
    reps: ['', [Validators.required, Validators.max(666)]],
    weight: ['', [Validators.required, Validators.max(666)]],
    notes: ['', [Validators.maxLength(200)]],
    exerciseId: ['', [Validators.required]],
  })
  onCancel = (event: Event) => {
    event.preventDefault();
    console.log(`[${WorkoutLogFormComponent.name}] - onCancel`);
    this.workoutLogForm.reset();
  }

  onSave = (event: Event) => {
    event.preventDefault();
    console.log(`[${WorkoutLogFormComponent.name}] - save`, this.workoutLogForm.value);

  }
}
