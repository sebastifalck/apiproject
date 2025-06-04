import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RuntimeCatalog } from './runtime-catalog';

describe('RuntimeCatalog', () => {
  let component: RuntimeCatalog;
  let fixture: ComponentFixture<RuntimeCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RuntimeCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RuntimeCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
