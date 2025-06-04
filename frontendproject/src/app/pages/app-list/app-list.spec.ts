import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppList } from './app-list';

describe('AppList', () => {
  let component: AppList;
  let fixture: ComponentFixture<AppList>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppList]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AppList);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
