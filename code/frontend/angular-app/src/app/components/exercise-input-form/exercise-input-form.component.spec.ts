import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExerciseInputFormComponent } from './exercise-input-form.component';

describe('ExerciseInputFormComponent', () => {
  let component: ExerciseInputFormComponent;
  let fixture: ComponentFixture<ExerciseInputFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ExerciseInputFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ExerciseInputFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
