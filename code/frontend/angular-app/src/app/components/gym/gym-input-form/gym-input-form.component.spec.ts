import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GymInputFormComponent } from './gym-input-form.component';

describe('GymInputFormComponent', () => {
  let component: GymInputFormComponent;
  let fixture: ComponentFixture<GymInputFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GymInputFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(GymInputFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
