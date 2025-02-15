import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MuscleGroupMappingComponent } from './muscle-group-mapping.component';

describe('MuscleGroupMappingComponent', () => {
  let component: MuscleGroupMappingComponent;
  let fixture: ComponentFixture<MuscleGroupMappingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MuscleGroupMappingComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(MuscleGroupMappingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
