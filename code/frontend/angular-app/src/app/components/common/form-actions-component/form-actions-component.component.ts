import {Component, Input} from '@angular/core';
import {MatButton} from "@angular/material/button";
import {FormGroup} from "@angular/forms";

@Component({
  selector: 'qb8-form-actions-component',
  standalone: true,
  imports: [
    MatButton
  ],
  templateUrl: './form-actions-component.component.html',
  styleUrl: './form-actions-component.component.css'
})
export class FormActionsComponentComponent {
  @Input({required: true}) inputForm: FormGroup | undefined;
  @Input() onCancel?: (event: Event) => void = () => {
  };
  @Input() onSave?: (event: Event) => void = () => {
  };


  save = (event: Event) => {
    if (this.inputForm && this.inputForm.valid) {
      console.log(`[${FormActionsComponentComponent.name}] - save`, this.inputForm?.value);
      this.onSave && this.onSave(event);
    }
  }
  cancel = (event: Event) => {
    console.log(`[${FormActionsComponentComponent.name}] - cancel`);
    this.onCancel && this.onCancel(event);
  }
}
