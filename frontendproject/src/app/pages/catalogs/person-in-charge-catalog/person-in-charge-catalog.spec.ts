import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonInChargeCatalog } from './person-in-charge-catalog';

describe('PersonInChargeCatalog', () => {
  let component: PersonInChargeCatalog;
  let fixture: ComponentFixture<PersonInChargeCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PersonInChargeCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PersonInChargeCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
