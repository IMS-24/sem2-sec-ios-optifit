import {Component, inject} from '@angular/core';
import {FormBuilder, ReactiveFormsModule, Validators} from "@angular/forms";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInput} from "@angular/material/input";
import {MatButton} from "@angular/material/button";
import {FormActionsComponentComponent} from "../common/form-actions-component/form-actions-component.component";

@Component({
  selector: 'qb8-exercise-input-form',
  standalone: true,
  imports: [ReactiveFormsModule,
    MatFormFieldModule,
    MatInput,
    MatButton, FormActionsComponentComponent],
  templateUrl: './exercise-input-form.component.html',
  styleUrl: './exercise-input-form.component.css'
})
export class ExerciseInputFormComponent {
  private formBuilder = inject(FormBuilder);
  exerciseInputForm = this.formBuilder.group({
    i18n_code: ['', [Validators.required, Validators.maxLength(20)]],
    description: ['', Validators.maxLength(500)],

  })
  onCancel = (event: Event) => {
    event.preventDefault();
    console.log(`[${ExerciseInputFormComponent.name}] - onCancel`);
    this.exerciseInputForm.reset();
  }

  onSave = (event: Event) => {
    event.preventDefault();
    console.log(`[${ExerciseInputFormComponent.name}] - save`, this.exerciseInputForm.value);

  }
}
