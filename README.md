# FotoCheck - Detector de Imágenes y Videos

FotoCheck es una aplicación que permite analizar imágenes y videos para determinar si son reales, generados por IA o manipulados digitalmente. La aplicación consta de un backend desarrollado en FastAPI y un frontend en Flutter, lo que permite su uso en múltiples plataformas.

## Características Principales

- **Análisis de Imágenes**: Detecta si una imagen es real, generada por IA o manipulada digitalmente.
- **Análisis de Videos**: Identifica deepfakes, inconsistencias de iluminación y manipulaciones en videos.
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
│   │   ├── analisis.py
│   │   └── analisis_video.py
│   ├── servicios/
│   │   ├── clasificador_imagenes.py
│   │   ├── clasificador_video.py
│   │   └── analisis_avanzado/
│   │       ├── analizador_completo.py
│   │       ├── deteccion_deepfake.py
│   │       ├── analisis_iluminacion.py
│   │       ├── analisis_metadatos.py
│   │       ├── analisis_segmentos.py
│   │       ├── analisis_audio.py
│   │       ├── estabilidad_camara.py
│   │       └── deteccion_cambios.py
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
│   │   ├── api_servicio.dart
│   │   └── api_servicio_demo.dart
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
- **v2.0**: Implementación de análisis de videos, optimización de rendimiento, y mejoras en la precisión de detección.

## Características Avanzadas

### Análisis de Imágenes Optimizado
- **Detección de Patrones IA**: Identifica patrones característicos de imágenes generadas por IA.
- **Análisis de Ruido**: Examina patrones de ruido inconsistentes que indican manipulación.
- **Detección de Artefactos**: Identifica artefactos de compresión anómalos.
- **Análisis de Metadatos**: Verifica la integridad de los metadatos EXIF.

### Análisis de Videos
- **Detección de Deepfakes**: Identifica rostros manipulados en videos mediante análisis de coherencia.
- **Análisis de Iluminación**: Detecta inconsistencias en la iluminación entre frames.
- **Análisis de Metadatos**: Verifica la integridad y coherencia de los metadatos del video.
- **Análisis por Segmentos**: Divide el video en segmentos para un análisis más preciso.
- **Análisis de Audio**: Detecta manipulaciones en la pista de audio.
- **Estabilidad de Cámara**: Analiza movimientos de cámara para identificar ediciones.

## Optimizaciones de Rendimiento
- **Procesamiento Paralelo**: Análisis simultáneo de diferentes aspectos del contenido.
- **Caché Inteligente**: Almacenamiento temporal de resultados intermedios para mejorar velocidad.
- **Escalado Adaptativo**: Ajuste automático de la resolución según el tamaño del contenido.
- **Extracción Eficiente de Frames**: Uso de generadores para minimizar el consumo de memoria.

## Licencia

Este proyecto está bajo la Licencia MIT.
