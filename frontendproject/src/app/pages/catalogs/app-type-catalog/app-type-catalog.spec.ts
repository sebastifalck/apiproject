import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppTypeCatalog } from './app-type-catalog';

describe('AppTypeCatalog', () => {
  let component: AppTypeCatalog;
  let fixture: ComponentFixture<AppTypeCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppTypeCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AppTypeCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
