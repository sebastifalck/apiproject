import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CountryCatalog } from './country-catalog';

describe('CountryCatalog', () => {
  let component: CountryCatalog;
  let fixture: ComponentFixture<CountryCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CountryCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CountryCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
