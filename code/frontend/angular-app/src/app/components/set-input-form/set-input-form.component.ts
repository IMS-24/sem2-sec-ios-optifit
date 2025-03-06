import {Component, inject} from '@angular/core';
import {FormBuilder, FormsModule, ReactiveFormsModule, Validators} from "@angular/forms";
import {MatButton} from "@angular/material/button";
import {MatFormField, MatLabel} from "@angular/material/form-field";
import {MatInput} from "@angular/material/input";
import {FormActionsComponentComponent} from "../common/form-actions-component/form-actions-component.component";

@Component({
  selector: 'qb8-set-input-form',
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
  templateUrl: './set-input-form.component.html',
  styleUrl: './set-input-form.component.css'
})
export class SetInputFormComponent {

  private formBuilder = inject(FormBuilder);
  setInputForm = this.formBuilder.group({
    order: ['', [Validators.required, Validators.max(666)]],
    reps: ['', [Validators.required, Validators.maxLength(666)]],
    weight: ['', [Validators.required, Validators.maxLength(5000)]],
  })
  onCancel = (event: Event) => {
    event.preventDefault();
    console.log(`[${SetInputFormComponent.name}] - onCancel`);
    this.setInputForm.reset();
  }

  onSave = (event: Event) => {
    event.preventDefault();
    console.log(`[${SetInputFormComponent.name}] - save`, this.setInputForm.value);

  }
}
