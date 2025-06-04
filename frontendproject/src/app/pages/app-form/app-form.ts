import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-app-form',
  templateUrl: './app-form.html',
  styleUrl: './app-form.scss',
  standalone: true,
  imports: [CommonModule, FormsModule]
})
export class AppForm implements OnInit {
  // Catálogos
  projects: any[] = [];
  persons: any[] = [];
  security: any[] = [];
  envs: any[] = [];
  countries: any[] = [];
  labels: any[] = [];
  pipelines: any[] = [];
  runtimes: any[] = [];
  repos: any[] = [];

  // Tipos de aplicación
  appTypes: any[] = [];
  selectedAppType: string = '';

  // Propiedades específicas
  microservices: any[] = [];
  datastages: any[] = [];
  databases: any[] = [];
  was: any[] = [];
  pims: any[] = [];

  // Formulario
  form: any = {
    app: '',
    repo_name: '',
    repo_url: '',
    id_project_directory: '',
    id_person_in_charge: '',
    id_security_champion: '',
    id_env_directory: '',
    id_country_directory: '',
    id_label_directory: '',
    id_app_type_directory: '',
    id_pipeline_properties_directory: '',
    id_runtime_directory: '',
    sonarqubepath_exec: '',
    // Propiedades específicas
    id_microservice_directory: '',
    id_datastage_properties_directory: '',
    id_database_properties_directory: '',
    id_was_properties_directory: '',
    id_pims_properties_directory: ''
  };

  constructor(private api: ApiService, private route: ActivatedRoute, private router: Router) {}

  ngOnInit() {
    this.api.getCatalog('project_directory').subscribe((data: any) => this.projects = data);
    this.api.getCatalog('person_in_charge').subscribe((data: any) => this.persons = data);
    this.api.getCatalog('security_champion').subscribe((data: any) => this.security = data);
    this.api.getCatalog('env_directory').subscribe((data: any) => this.envs = data);
    this.api.getCatalog('country_directory').subscribe((data: any) => this.countries = data);
    this.api.getCatalog('label_directory').subscribe((data: any) => this.labels = data);
    this.api.getCatalog('pipeline_properties_directory').subscribe((data: any) => this.pipelines = data);
    this.api.getCatalog('runtime_directory').subscribe((data: any) => this.runtimes = data);
    this.api.getCatalog('app_directory').subscribe((data: any) => this.repos = data);
    this.api.getCatalog('app_type_directory').subscribe((data: any) => this.appTypes = data);
    this.api.getCatalog('microservice_properties_directory').subscribe((data: any) => this.microservices = data);
    this.api.getCatalog('datastage_properties_directory').subscribe((data: any) => this.datastages = data);
    this.api.getCatalog('database_properties_directory').subscribe((data: any) => this.databases = data);
    this.api.getCatalog('was_properties_directory').subscribe((data: any) => this.was = data);
    this.api.getCatalog('pims_properties_directory').subscribe((data: any) => this.pims = data);

    // Lógica de edición: si hay id en la ruta, cargar datos
    this.route.paramMap.subscribe(params => {
      const id = params.get('id');
      if (id) {
        this.api.getAppById(+id).subscribe((app: any) => {
          this.form = { ...this.form, ...app };
          this.selectedAppType = app.app_type;
        });
      }
    });
  }

  onAppTypeChange() {
    // Limpiar propiedades específicas
    this.form.id_microservice_directory = '';
    this.form.id_datastage_properties_directory = '';
    this.form.id_database_properties_directory = '';
    this.form.id_was_properties_directory = '';
    this.form.id_pims_properties_directory = '';
  }

  submit() {
    // Solo enviar el campo específico según el tipo
    const data = { ...this.form };
    if (this.selectedAppType === 'microservice') {
      delete data.id_datastage_properties_directory;
      delete data.id_database_properties_directory;
      delete data.id_was_properties_directory;
      delete data.id_pims_properties_directory;
    } else if (this.selectedAppType === 'datastage') {
      delete data.id_microservice_directory;
      delete data.id_database_properties_directory;
      delete data.id_was_properties_directory;
      delete data.id_pims_properties_directory;
    } else if (this.selectedAppType === 'database') {
      delete data.id_microservice_directory;
      delete data.id_datastage_properties_directory;
      delete data.id_was_properties_directory;
      delete data.id_pims_properties_directory;
    } else if (this.selectedAppType === 'was') {
      delete data.id_microservice_directory;
      delete data.id_datastage_properties_directory;
      delete data.id_database_properties_directory;
      delete data.id_pims_properties_directory;
    } else if (this.selectedAppType === 'pims') {
      delete data.id_microservice_directory;
      delete data.id_datastage_properties_directory;
      delete data.id_database_properties_directory;
      delete data.id_was_properties_directory;
    }
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      // No hay updateApp, solo crear nueva app
      this.api.createApp(data).subscribe(() => {
        this.router.navigate(['/apps']);
      });
    } else {
      this.api.createApp(data).subscribe(() => {
        this.router.navigate(['/apps']);
      });
    }
  }
}
