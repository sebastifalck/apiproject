import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

@Component({
  selector: 'app-catalog-list',
  templateUrl: './catalog-list.html',
  styleUrl: './catalog-list.scss',
  standalone: true,
  imports: [CommonModule, FormsModule]
})
export class CatalogList {
  catalogName = '';
  items: any[] = [];
  loading = false;
  error = '';

  constructor(private api: ApiService) {}

  loadCatalog() {
    if (!this.catalogName) return;
    this.loading = true;
    this.api.getCatalog(this.catalogName).subscribe({
      next: data => { this.items = data; this.loading = false; },
      error: err => { this.error = 'Error al cargar catálogo.'; this.loading = false; }
    });
  }
}
