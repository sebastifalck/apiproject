import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PipelineCatalog } from './pipeline-catalog';

describe('PipelineCatalog', () => {
  let component: PipelineCatalog;
  let fixture: ComponentFixture<PipelineCatalog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PipelineCatalog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PipelineCatalog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
