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
