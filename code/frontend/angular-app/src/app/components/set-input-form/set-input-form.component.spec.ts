import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SetInputFormComponent } from './set-input-form.component';

describe('SetInputFormComponent', () => {
  let component: SetInputFormComponent;
  let fixture: ComponentFixture<SetInputFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SetInputFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SetInputFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
