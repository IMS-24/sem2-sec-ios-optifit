import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GymTableViewComponent } from './gym-table-view.component';

describe('GymTableViewComponent', () => {
  let component: GymTableViewComponent;
  let fixture: ComponentFixture<GymTableViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GymTableViewComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(GymTableViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
