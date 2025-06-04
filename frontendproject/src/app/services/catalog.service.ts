import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class CatalogService {
  private apiUrl = 'http://localhost:8080/aux';

  constructor(private http: HttpClient) {}

  getCatalog(tabla: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/${tabla}`);
  }
}