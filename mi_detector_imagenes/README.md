# FotoCheck - Frontend Flutter

Aplicación móvil y de escritorio para la detección de imágenes y videos manipulados o generados por IA.

## Descripción

FotoCheck es una aplicación desarrollada en Flutter que permite a los usuarios analizar imágenes y videos para determinar si son reales, generados por IA o manipulados digitalmente. La aplicación ofrece una interfaz intuitiva y moderna, con soporte para modo oscuro y resultados detallados.

## Características Principales

- **Análisis de Imágenes**: Detecta si una imagen es real, generada por IA o manipulada.
- **Visualización de Detalles**: Muestra información técnica sobre el análisis realizado.
- **Modo Demostración**: Funciona sin necesidad de conexión al backend.
- **Diseño Adaptativo**: Funciona en móviles, tablets y escritorio.
- **Modo Oscuro**: Interfaz adaptable a las preferencias del usuario.
- **Compartir Resultados**: Permite compartir los resultados del análisis.
- **Experiencia de Usuario Optimizada**: Animaciones fluidas y feedback visual.

## Estructura del Proyecto

```
mi_detector_imagenes/
├── assets/
│   └── logo.svg                 # Logo de la aplicación
├── lib/
│   ├── main.dart                # Punto de entrada de la aplicación
│   ├── models/
│   │   └── resultado_modelo.dart # Modelo de datos para resultados
│   ├── routes/
│   │   └── app_routes.dart      # Configuración de rutas de navegación
│   ├── screens/
│   │   ├── pantalla_inicio.dart        # Pantalla principal
│   │   ├── pantalla_previsualizacion.dart # Previsualización de imagen
│   │   ├── pantalla_resultado.dart     # Resultados del análisis
│   │   └── pantalla_detalles.dart      # Detalles técnicos
│   ├── services/
│   │   ├── api_servicio.dart    # Servicio para comunicación con backend
│   │   └── api_servicio_demo.dart # Servicio de demostración sin backend
│   └── widgets/
│       ├── boton_personalizado.dart    # Botones personalizados
│       └── imagen_previsualizacion.dart # Widget de previsualización
└── pubspec.yaml                 # Configuración y dependencias
```

## Requisitos

- Flutter 3.0.0 o superior
- Dart 2.17.0 o superior
- Dispositivo Android, iOS o computadora con Windows/macOS/Linux

## Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/tu-usuario/FotoCheck.git
cd FotoCheck/mi_detector_imagenes
```

2. Obtener dependencias:
```bash
flutter pub get
```

3. Ejecutar la aplicación:
```bash
flutter run
```

## Modos de Funcionamiento

### Modo Demostración
La aplicación incluye un modo de demostración que funciona sin necesidad de conexión al backend. Este modo genera resultados aleatorios para fines de demostración y prueba.

### Modo Completo
Para utilizar todas las funcionalidades, es necesario tener el backend en ejecución. La aplicación se comunicará con el backend para realizar análisis precisos de las imágenes y videos.

## Compilación para Producción

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows
```bash
flutter build windows --release
```

## Mejoras Recientes

- **Optimización de Código**: Mejora del formato y estructura del código para mayor legibilidad y mantenimiento.
- **Corrección de Advertencias**: Eliminación de variables no utilizadas e importaciones innecesarias.
- **Mejora de Interfaz**: Refinamiento de la experiencia de usuario con mejor feedback visual.
- **Compatibilidad con Análisis de Videos**: Preparación de la interfaz para soportar análisis de videos (próximamente).

## Contribución

Para contribuir al proyecto:

1. Crear una rama para tu característica:
```bash
git checkout -b feature/nueva-caracteristica
```

2. Realizar cambios y hacer commit:
```bash
git commit -m "Añadir nueva característica"
```

3. Enviar cambios:
```bash
git push origin feature/nueva-caracteristica
```

4. Crear un Pull Request

## Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo LICENSE para más detalles.
