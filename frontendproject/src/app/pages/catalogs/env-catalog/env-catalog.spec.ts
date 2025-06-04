import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EnvCatalog } from './env-catalog';

describe('EnvCatalog', () => {
  let component: EnvCatalog;
  let fixture: ComponentFixture<EnvCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EnvCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EnvCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
