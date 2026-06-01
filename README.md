# Ligo App

Prueba técnica desarrollada con Flutter para la posición de Desarrollador Flutter.

## Descripción

Este proyecto implementa módulos de autenticación y movimientos para una billetera digital.

## Instalación

### Requisitos

- Flutter `3.41.0`
- FVM (recomendado)

> El proyecto utiliza FVM para garantizar una versión consistente de Flutter entre distintos entornos de desarrollo.

### Clonar el proyecto

```bash
git clone https://github.com/Juanca0312/ligo_app
cd ligo_app
```

### Si utilizas FVM

Instalar la versión de Flutter configurada en el proyecto:

```bash
fvm use
```

Instalar dependencias:

```bash
fvm flutter pub get
```

### Si no utilizas FVM

Verificar que tengas instalada la versión correcta de Flutter:

```bash
flutter --version
```

La versión utilizada durante el desarrollo es:

```text
Flutter 3.41.0
```

Instalar dependencias:

```bash
flutter pub get
```

## Configuración del entorno

La aplicación utiliza variables de entorno mediante `--dart-define-from-file`.

### Archivo de entorno

Crear un archivo basado en el ejemplo para el ambiente de desarrollo:

```bash
cp .env/example.env .env/development.env
```

### Ejecutar la aplicación

Con FVM:

```bash
fvm flutter run --dart-define-from-file=.env/development.env
```

Sin FVM:

```bash
flutter run --dart-define-from-file=.env/development.env
```

## Ejecución en VSCode

El proyecto ya cuenta con configuración de launch.json, por lo que también puedes ejecutar la app directamente desde VSCode utilizando el botón Run and Debug sin necesidad de ejecutar comandos manuales.

## Testing

Se implementaron tests unitarios para los principales módulos de la aplicación

```bash
flutter test
```

## Mock / contrato esperado de la API
Incluye /auth/login (token + user) y /movements con type: in | out y status: pending | completed | failed; valores no reconocidos se mapean como unknown y se filtran para evitar inconsistencias en UI.

### /auth/login
```json
{
  "token": "token_123",
  "user": {
    "id": "user_id",
    "name": "Juan Hernandez"
  }
}
```
### /movements
```json
[
  {
    "id": "mov_003",
    "description": "Pago de Netflix",
    "amount": 15.99,
    "type": "out",
    "status": "pending"
  }
]
```
## Arquitectura

El proyecto está estructurado siguiendo Clean Architecture orientada a módulos por feature, separando claramente responsabilidades entre capas de data, domain y presentation.

Se trabaja principalmente con tres módulos:

- Auth: gestión de autenticación, login, y control de sesión del usuario.
- Movements: encargado del listado, filtrado, búsqueda y detalle de movimientos de la billetera.
- Core: contiene componentes transversales como manejo de errores, networking, interceptores, almacenamiento seguro, theming y utilidades compartidas.
  
### Seguridad

La seguridad se basa en una capa centralizada de gestión de sesión:

Se utiliza Secure Storage para el almacenamiento seguro del token.
Un Session Manager abstrae el acceso al almacenamiento y expone operaciones como obtener token, validar sesión y limpiar datos sensibles.
Un Auth Interceptor inyecta automáticamente el token en cada request y maneja respuestas 401 Unauthorized, forzando el logout y limpieza de sesión.
El Session Cubit reacciona a cambios del Session Manager, permitiendo actualizar el estado global de autenticación y restringir navegación cuando la sesión no es válida.

<img width="2212" height="1881" alt="diagrama_ligo" src="https://github.com/user-attachments/assets/c4e17044-9bc3-4547-9b62-7cebd4a1782b" />

### UI System (Theme, spacing y componentes)

La aplicación cuenta con un sistema de diseño centralizado basado en ThemeData, ColorScheme y tokens de diseño.

- Tema y colores: definidos en LigoLightTheme y LigoColor, centralizando la configuración visual (colores, inputs, botones, AppBar y estados).
- Spacing: gestionado mediante LigoSpacing, garantizando consistencia en márgenes y paddings a nivel global.
- Extensibilidad de componentes: los componentes reutilizables se implementan en core/presentation/widgets, encapsulando widgets base de Flutter (ej. TextFormField) para estandarizar comportamiento, estilos y reusabilidad.
- Escalabilidad: nuevos componentes deben seguir el patrón de wrappers reutilizables, desacoplados de lógica de negocio y basados en el theme system para asegurar consistencia visual.

## Capturas de pantalla
<img height="300" alt="Simulator Screenshot - iPhone 16 Pro - 2026-06-01 at 11 02 20" src="https://github.com/user-attachments/assets/e210d52f-b3e0-42d5-ad2b-7b8ef7a070bf" />
<img height="300" alt="Simulator Screenshot - iPhone 16 Pro - 2026-06-01 at 11 02 44" src="https://github.com/user-attachments/assets/09ce19ed-de34-4619-8041-1ec066e596f5" />
<img height="300" alt="Simulator Screenshot - iPhone 16 Pro - 2026-06-01 at 11 03 39" src="https://github.com/user-attachments/assets/a3b3ad84-9d61-458b-8031-ca9c7b0ecd6d" />
<img height="300" alt="Simulator Screenshot - iPhone 16 Pro - 2026-06-01 at 11 03 46" src="https://github.com/user-attachments/assets/fe2b1a05-e5f0-43e9-96f7-e117b4f3f580" />

Demo: [https://www.youtube.com/watch?v=wM7-_tB_Uw0](https://www.youtube.com/watch?v=wM7-_tB_Uw0)


## Uso de IA
### Herramientas utilizadas
ChatGPT y Copilot

### Para qué se utilizó la IA
- Se utilizó IA principalmente para mejorar la productividad, mantener la calidad del código y apoyar en decisiones técnicas.

### Se aceptó código generado por IA principalmente en:
- Código repetitivo (Principalmente en métodos de capas de presentación, dominio y data).
- Estructuras base de tests unitarios.
- Refactorizaciones que no alteraban la lógica de negocio.
- Autocompletado de código estándar en Flutter (widgets, estados, manejo de UI states).

### Código descartado o modificado
- Soluciones que no se acoplaban a arquitectura propuesta
- Propuestas con sobreingeniería
- Refactorizaciones innecesarias

### Validación manual realizada
Todo el código generado o asistido por IA fue validado manualmente. Las validaciones se realizaron validando el comportamiento esperado corriendo la aplicación y con apoyo con las pruebas unitarias. Se probaron manualmente todos los happy y unhappy paths 

### Se identificaron los siguientes riesgos asociados al uso de herramientas de IA:
- Posible generación de código incorrecto o incompleto, especialmente en lógica de negocio.
- Riesgo de acoplamiento entre capas, si no se valida con principios de arquitectura limpia.
- Inconsistencias con documentación de elementos públicos
- Posibles soluciones no óptimas
- Posible filtración de datos sensibles
