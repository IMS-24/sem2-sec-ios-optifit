import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MuscleGroupMappingViewComponent } from './muscle-group-mapping-view.component';

describe('MuscleGroupMappingViewComponent', () => {
  let component: MuscleGroupMappingViewComponent;
  let fixture: ComponentFixture<MuscleGroupMappingViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MuscleGroupMappingViewComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(MuscleGroupMappingViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
