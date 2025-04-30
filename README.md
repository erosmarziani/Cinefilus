# Proyecto Cinefilus - Backend en Node.js y Frontend en Flutter

Este proyecto consiste en una aplicación web que permite explorar películas y series mediante una API externa. El backend desarrollado en Node.js actúa como intermediario entre el cliente y la API externa, y el frontend en Flutter muestra los datos al usuario.

## Requisitos del profesor implementados

✅ Uso de `FutureBuilder` para cargar preferencias de modo oscuro desde `SharedPreferences`.  
✅ Uso de `Provider` como gestor de estado para manejar películas y búsqueda dinámica.  
✅ Uso de `SharedPreferences` para persistir el estado del modo oscuro.  
✅ Uso de `http` y variables de entorno (usando un archivo `.env`) para peticiones a la API externa.  
✅ Modelo de datos generado automáticamente con `quicktype.io`.

## Estructura del proyecto

```
raíz-del-proyecto/
│
├── back/       → Backend en Node.js
│   ├── app.js
│   ├── .env
│   ├── .env.example
│   └── ...
│
├── front/      → Frontend en Flutter
│   ├── lib/
│   ├── .env
│   ├── .env.example
│   └── ...
```
## 🌙 Cambio de Tema (Oscuro / Claro)

Se utiliza `SharedPreferences` para guardar la preferencia del usuario respecto al tema, y se carga mediante un `FutureBuilder` en el `Drawer`.

## 🎥 Categorías implementadas

- **Películas Populares**
- **Mejores Series**
- **Próximos Estrenos**
- **Actores**

Cada una accede a un endpoint distinto y muestra los datos de forma optimizada.

## Configuración del entorno

Crear un archivo `.env` en la carpeta `back/` y otro en `front/`, ambos basados en sus respectivos archivos `.env.example`.

### back/.env.example

```
BASE_URL=https://api.themoviedb.org/3
API_KEY=ec515e4aaa66cb32886fbc0b5760a352
```

### front/.env.example

```
BASE_URL=http://localhost:3000/api/v1/
```


## Instalación de dependencias

### Backend

```
cd back
npm install
```

### Frontend

```
cd front
flutter pub get
```

## Ejecución del proyecto

### Iniciar el backend

Desde la raíz del proyecto:

```
cd back
nodemon app.js
```

El backend se ejecuta por defecto en `http://localhost:3000`.

### Iniciar el frontend

En una nueva terminal:

```
cd front
flutter run -d chrome
```

La aplicación se abrirá en el navegador Google Chrome y consumirá la API del backend.

## Notas

- Es necesario tener el backend corriendo antes de iniciar el frontend para que pueda consumir los datos correctamente.
- Se recomienda usar `nodemon` en desarrollo para reiniciar el servidor automáticamente ante cambios.
