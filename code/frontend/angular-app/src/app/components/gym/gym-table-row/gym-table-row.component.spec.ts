import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GymTableRowComponent } from './gym-table-row.component';

describe('GymTableRowComponent', () => {
  let component: GymTableRowComponent;
  let fixture: ComponentFixture<GymTableRowComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GymTableRowComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(GymTableRowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
