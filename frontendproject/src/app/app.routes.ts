import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', redirectTo: 'apps', pathMatch: 'full' },
  { path: 'apps', loadComponent: () => import('./pages/app-list/app-list').then(m => m.AppList) },
  { path: 'apps/new', loadComponent: () => import('./pages/app-form/app-form').then(m => m.AppForm) },
  { path: 'catalog-list', loadComponent: () => import('./pages/catalog-list/catalog-list').then(m => m.CatalogList) },
  { path: 'catalog-form', loadComponent: () => import('./pages/catalog-form/catalog-form').then(m => m.CatalogForm) },

  // Subcatálogos de tablas auxiliares
  { path: 'catalogs/env', loadComponent: () => import('./pages/catalogs/env-catalog/env-catalog').then(m => m.EnvCatalog) },
  { path: 'catalogs/country', loadComponent: () => import('./pages/catalogs/country-catalog/country-catalog').then(m => m.CountryCatalog) },
  { path: 'catalogs/label', loadComponent: () => import('./pages/catalogs/label-catalog/label-catalog').then(m => m.LabelCatalog) },
  { path: 'catalogs/runtime', loadComponent: () => import('./pages/catalogs/runtime-catalog/runtime-catalog').then(m => m.RuntimeCatalog) },
  { path: 'catalogs/pipeline', loadComponent: () => import('./pages/catalogs/pipeline-catalog/pipeline-catalog').then(m => m.PipelineCatalog) },
  { path: 'catalogs/person-in-charge', loadComponent: () => import('./pages/catalogs/person-in-charge-catalog/person-in-charge-catalog').then(m => m.PersonInChargeCatalog) },
  { path: 'catalogs/security-champion', loadComponent: () => import('./pages/catalogs/security-champion-catalog/security-champion-catalog').then(m => m.SecurityChampionCatalog) },
  { path: 'catalogs/app-type', loadComponent: () => import('./pages/catalogs/app-type-catalog/app-type-catalog').then(m => m.AppTypeCatalog) }
];
