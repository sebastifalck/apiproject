import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabelCatalog } from './label-catalog';

describe('LabelCatalog', () => {
  let component: LabelCatalog;
  let fixture: ComponentFixture<LabelCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LabelCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabelCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
