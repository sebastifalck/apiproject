import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../../services/api';

@Component({
  selector: 'app-env-catalog',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './env-catalog.html',
  styleUrl: './env-catalog.scss'
})
export class EnvCatalog implements OnInit {
  items: any[] = [];
  form: any = { name: '' };
  editingId: number|null = null;
  loading = false;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit() {
    this.loadItems();
  }

  loadItems() {
    this.loading = true;
    this.api.getCatalog('env_directory').subscribe({
      next: data => { this.items = data; this.loading = false; },
      error: err => { this.error = 'Error al cargar.'; this.loading = false; }
    });
  }

  edit(item: any) {
    this.form = { name: item.name };
    this.editingId = item.id;
  }

  cancel() {
    this.form = { name: '' };
    this.editingId = null;
  }

  submit() {
    if (!this.form.name) return;
    this.loading = true;
    if (this.editingId) {
      // No existe updateCatalogItem, solo crear nuevo ítem
      this.api.createCatalogItem('env_directory', this.form).subscribe({
        next: () => { this.loadItems(); this.cancel(); },
        error: err => { this.error = 'Error al actualizar.'; this.loading = false; }
      });
    } else {
      this.api.createCatalogItem('env_directory', this.form).subscribe({
        next: () => { this.loadItems(); this.cancel(); },
        error: err => { this.error = 'Error al agregar.'; this.loading = false; }
      });
    }
  }
}
