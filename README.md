# FotoCheck - Detector de Imágenes

FotoCheck es una aplicación que permite analizar imágenes para determinar si son reales, generadas por IA o manipuladas digitalmente. La aplicación consta de un backend desarrollado en FastAPI y un frontend en Flutter, lo que permite su uso en múltiples plataformas.

## Características Principales

- **Análisis de Imágenes**: Detecta si una imagen es real, generada por IA o manipulada digitalmente.
- **Interfaz Intuitiva**: Diseño moderno y fácil de usar con soporte para modo oscuro.
- **Detalles Técnicos**: Proporciona información detallada sobre las características analizadas.
- **Recomendaciones**: Ofrece consejos sobre cómo utilizar la imagen según su clasificación.
- **Compartir Resultados**: Permite compartir los resultados del análisis.
- **Multiplataforma**: Funciona en Windows, Android e iOS.

## Estructura del Proyecto

### Backend (FastAPI)

```
backend_detector/
├── app/
│   ├── modelos/
│   │   └── resultado.py
│   ├── routes/
│   │   └── analisis.py
│   ├── services/
│   │   └── clasificador.py
│   ├── utils/
│   │   └── procesador_imagen.py
│   └── main.py
└── requirements.txt
```

### Frontend (Flutter)

```
mi_detector_imagenes/
├── assets/
│   └── logo.svg
├── lib/
│   ├── models/
│   │   └── resultado_modelo.dart
│   ├── routes/
│   │   └── app_routes.dart
│   ├── screens/
│   │   ├── pantalla_detalles.dart
│   │   ├── pantalla_inicio.dart
│   │   ├── pantalla_previsualizacion.dart
│   │   └── pantalla_resultado.dart
│   ├── services/
│   │   └── api_servicio.dart
│   ├── widgets/
│   │   ├── boton_personalizado.dart
│   │   └── imagen_previsualizacion.dart
│   └── main.dart
└── pubspec.yaml
```

## Instalación y Ejecución

### Backend

1. Navega al directorio del backend:
   ```
   cd backend_detector
   ```

2. Instala las dependencias:
   ```
   pip install -r requirements.txt
   ```

3. Inicia el servidor:
   ```
   uvicorn app.main:app --reload
   ```

### Frontend

1. Navega al directorio del frontend:
   ```
   cd mi_detector_imagenes
   ```

2. Obtén las dependencias:
   ```
   flutter pub get
   ```

3. Ejecuta la aplicación:
   ```
   flutter run
   ```

## Versiones

- **v1.0**: Implementación inicial con funcionalidad básica.
- **v1.1**: Mejoras visuales y funcionales en la interfaz de usuario, corrección de errores y soporte para modo oscuro.

## Licencia

Este proyecto está bajo la Licencia MIT.
