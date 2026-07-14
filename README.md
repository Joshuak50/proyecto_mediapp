# Mediapp

Aplicación móvil para el manejo y la administración de medicamentos, diseñada para ayudar a los usuarios a organizar sus tratamientos, recibir recordatorios de dosis y llevar un historial de consumo, reduciendo el riesgo de olvidos o errores en la medicación.

---

## 📌 Características

* Registro y gestión de medicamentos
* Registro de usuarios
* Gestión de horarios
* Interfaz intuitiva
* Sistema CRUD completo

---

## 🛠 Tecnologías utilizadas

* PHP
* Laravel
* HTML
* PostgreSQL
* Bootstrap
* Flutter
* Dart

---

## ⚙️ Instalación

Este proyecto está compuesto por dos partes:

- **Backend:** API desarrollada en Laravel
- **Frontend:** Aplicación móvil desarrollada en Flutter

Sigue estos pasos para ejecutar el proyecto en tu entorno local.

---

### 🖥️ Backend (Laravel)

1. Clonar el repositorio

```bash
git clone https://github.com/Joshuak50/proyecto_mediapp.git
```

2. Entrar a la carpeta del backend

```bash
cd proyecto_mediapp/mediapp_backend
```

3. Instalar dependencias de PHP

```bash
composer install
```

4. Crear archivo `.env`

```bash
cp .env.example .env
```

5. Generar clave de la aplicación

```bash
php artisan key:generate
```

6. Configurar base de datos en `.env`

```env
DB_DATABASE=mediapp
DB_USERNAME=
DB_PASSWORD=
```

7. Ejecutar migraciones

```bash
php artisan migrate
```

8. Ejecutar el servidor

```bash
php artisan serve
```

El backend estará disponible en:

```
http://127.0.0.1:8000
```

---

### 📱 Frontend (Flutter)

1. Entrar a la carpeta del frontend

```bash
cd proyecto_mediapp/mediapp_frontend
```

2. Instalar dependencias de Flutter

```bash
flutter pub get
```

3. Configurar la URL del backend

En el archivo donde definas la URL base de la API `lib/Utilerias/Ambiente.dart`, asegúrate de apuntar a tu servidor Laravel:

```dart
static String urlServe = 'http://127.0.0.1:8000';
```

> ⚠️ Si estás probando en un emulador Android, usa `http://127.0.0.1:8000/api` en lugar de `127.0.0.1`, ya que el emulador no accede directamente al localhost de tu máquina.

4. Ejecutar la aplicación

```bash
flutter run
```

---

##  Autor

**Joshua Gabriel Bello Rivera**  
Ingeniero en Desarrollo y Gestión de Software

---

## 📄 Licencia

Este proyecto es de uso académico y educativo.
