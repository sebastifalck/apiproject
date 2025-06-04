import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

@Component({
  selector: 'app-catalog-form',
  templateUrl: './catalog-form.html',
  styleUrl: './catalog-form.scss',
  standalone: true,
  imports: [CommonModule, FormsModule]
})
export class CatalogForm {
  catalogName = '';
  form: any = {};
  message = '';
  error = '';

  constructor(private api: ApiService) {}

  getKeys() {
    return Object.keys(this.form);
  }

  submit() {
    if (!this.catalogName || Object.keys(this.form).length === 0) return;
    this.api.createCatalogItem(this.catalogName, this.form).subscribe({
      next: res => { this.message = 'Ítem agregado con ID ' + res.id; this.error = ''; },
      error: err => { this.error = 'Error al agregar ítem.'; this.message = ''; }
    });
  }
}
