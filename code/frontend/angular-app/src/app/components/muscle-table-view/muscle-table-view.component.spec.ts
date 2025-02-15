import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MuscleTableViewComponent } from './muscle-table-view.component';

describe('MuscleTableViewComponent', () => {
  let component: MuscleTableViewComponent;
  let fixture: ComponentFixture<MuscleTableViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MuscleTableViewComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(MuscleTableViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
