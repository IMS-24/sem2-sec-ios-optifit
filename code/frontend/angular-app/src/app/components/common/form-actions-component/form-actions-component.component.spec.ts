import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormActionsComponentComponent } from './form-actions-component.component';

describe('FormActionsComponentComponent', () => {
  let component: FormActionsComponentComponent;
  let fixture: ComponentFixture<FormActionsComponentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FormActionsComponentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(FormActionsComponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
