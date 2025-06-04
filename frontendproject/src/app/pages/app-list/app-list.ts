import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ApiService } from '../../services/api';

@Component({
  selector: 'app-app-list',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './app-list.html',
  styleUrl: './app-list.scss'
})
export class AppList implements OnInit {
  apps: any[] = [];
  loading = false;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit() {
    this.loadApps();
  }

  loadApps() {
    this.loading = true;
    this.api.getApps().subscribe({
      next: data => { this.apps = data; this.loading = false; },
      error: err => { this.error = 'Error al cargar aplicaciones.'; this.loading = false; }
    });
  }
}
