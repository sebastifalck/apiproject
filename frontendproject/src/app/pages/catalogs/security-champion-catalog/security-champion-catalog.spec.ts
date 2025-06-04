import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SecurityChampionCatalog } from './security-champion-catalog';

describe('SecurityChampionCatalog', () => {
  let component: SecurityChampionCatalog;
  let fixture: ComponentFixture<SecurityChampionCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SecurityChampionCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SecurityChampionCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
