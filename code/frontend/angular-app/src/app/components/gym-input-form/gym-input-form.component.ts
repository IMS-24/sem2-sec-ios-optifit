import {Component, inject} from '@angular/core';
import {FormBuilder, ReactiveFormsModule, Validators} from "@angular/forms";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInput} from "@angular/material/input";
import {MatButton} from "@angular/material/button";
import {FormActionsComponentComponent} from "../common/form-actions-component/form-actions-component.component";

@Component({
  selector: 'qb8-gym-input-form',
  standalone: true,
  imports: [
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInput,
    MatButton,
    FormActionsComponentComponent
  ],
  templateUrl: './gym-input-form.component.html',
  styleUrl: './gym-input-form.component.css'
})
export class GymInputFormComponent {

  private formBuilder = inject(FormBuilder);
  gymInputForm = this.formBuilder.group({
    name: ['', [Validators.required, Validators.maxLength(20)]],
    address: ['', Validators.maxLength(100)],
    city: ['', Validators.maxLength(50)],
    zipCode: ['', Validators.max(9999)],
  })

  onCancel = (event: Event) => {
    event.preventDefault();
    console.log(`[${GymInputFormComponent.name}] - onCancel`);
    this.gymInputForm.reset();
  }

  onSave = (event: Event) => {
    event.preventDefault();
    console.log(`[${GymInputFormComponent.name}] - save`, this.gymInputForm.value);
    
  }
}

