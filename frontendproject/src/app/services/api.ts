import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private baseUrl = ''; // Proxy Nginx

  constructor(private http: HttpClient) { }

  // Obtener catálogo auxiliar (GET /api/aux/{tabla})
  getCatalog(tabla: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/aux/${tabla}`);
  }

  // Obtener todas las aplicaciones (GET /api/consult)
  getApps(): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/consult`);
  }

  // Obtener una aplicación por id (GET /api/consult?id=ID)
  getAppById(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}/consult?id=${id}`);
  }

  // Crear aplicación (POST /api/apps)
  createApp(data: any): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}/apps`, data);
  }

  // Agregar ítem a catálogo auxiliar (POST /api/aux/{tabla})
  createCatalogItem(tabla: string, data: any): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}/aux/${tabla}`, data);
  }
}
