import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MuscleGroupTableViewComponent } from './muscle-group-table-view.component';

describe('MuscleGroupTableViewComponent', () => {
  let component: MuscleGroupTableViewComponent;
  let fixture: ComponentFixture<MuscleGroupTableViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MuscleGroupTableViewComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(MuscleGroupTableViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
