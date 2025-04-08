import 'dart:io';
import 'dart:math';
import '../models/resultado_modelo.dart';

/// Versión de demostración del servicio API que no requiere conexión al backend
class ApiServicioDemo {
  // Genera un resultado aleatorio para demostración
  Future<ResultadoModelo> analizarImagen(File imagen) async {
    // Simulamos un tiempo de procesamiento
    await Future.delayed(const Duration(seconds: 2));

    // Generamos un tipo aleatorio
    final random = Random();
    final tipoIndex = random.nextInt(3);
    String tipo;
    String colorHex;

    switch (tipoIndex) {
      case 0:
        tipo = 'real';
        colorHex = '#4CAF50'; // Verde
        break;
      case 1:
        tipo = 'IA';
        colorHex = '#2196F3'; // Azul
        break;
      case 2:
        tipo = 'manipulada';
        colorHex = '#FF9800'; // Naranja
        break;
      default:
        tipo = 'desconocido';
        colorHex = '#9E9E9E'; // Gris
    }

    // Generamos una confianza aleatoria entre 70% y 98%
    final confianza = 70.0 + random.nextInt(29).toDouble();

    // Generamos detalles aleatorios
    final detalles = {
      'patron_repetitivo': random.nextBool(),
      'inconsistencia_iluminacion': random.nextBool(),
      'artefactos_compresion': random.nextBool(),
      'ruido_coherente': random.nextBool(),
      'textura_natural': !random.nextBool(),
      'bordes_artificiales': random.nextBool(),
      'metadata_intacta': !random.nextBool(),
      'consistencia_perspectiva': !random.nextBool(),
      'simetria_facial': random.nextDouble() * 100,
      'detalle_excesivo': random.nextDouble() * 100,
    };

    // Creamos el modelo de resultado
    return ResultadoModelo(
      tipo: tipo,
      confianza: confianza,
      colorHexadecimal: colorHex,
      detalles: detalles,
      esVideo: false,
    );
  }
  
  // Genera un resultado aleatorio para demostración de análisis de video
  Future<ResultadoModelo> analizarVideo(File video) async {
    // Simulamos un tiempo de procesamiento más largo para videos
    await Future.delayed(const Duration(seconds: 4));

    // Generamos un tipo aleatorio
    final random = Random();
    final tipoIndex = random.nextInt(3);
    String tipo;
    String colorHex;

    switch (tipoIndex) {
      case 0:
        tipo = 'real';
        colorHex = '#4CAF50'; // Verde
        break;
      case 1:
        tipo = 'IA';
        colorHex = '#2196F3'; // Azul
        break;
      case 2:
        tipo = 'manipulada';
        colorHex = '#FF9800'; // Naranja
        break;
      default:
        tipo = 'desconocido';
        colorHex = '#9E9E9E'; // Gris
    }

    // Generamos una confianza aleatoria entre 70% y 98%
    final confianza = 70.0 + random.nextInt(29).toDouble();

    // Generamos detalles aleatorios específicos para videos
    final detalles = {
      // Detalles generales
      'patron_repetitivo': random.nextBool(),
      'inconsistencia_iluminacion': random.nextBool(),
      'artefactos_compresion': random.nextBool(),
      'ruido_coherente': random.nextBool(),
      'textura_natural': !random.nextBool(),
      'bordes_artificiales': random.nextBool(),
      'metadata_intacta': !random.nextBool(),
      'consistencia_perspectiva': !random.nextBool(),
      
      // Detalles específicos de videos
      'sincronizacion_audio': random.nextDouble() * 100,
      'estabilidad_camara': random.nextDouble() * 100,
      'coherencia_iluminacion_temporal': random.nextDouble() * 100,
      'deteccion_deepfake': random.nextBool(),
      'cambios_abruptos': random.nextInt(5), // Número de cambios abruptos detectados
      'segmentos_manipulados': random.nextInt(3), // Número de segmentos potencialmente manipulados
    };

    // Creamos el modelo de resultado
    return ResultadoModelo(
      tipo: tipo,
      confianza: confianza,
      colorHexadecimal: colorHex,
      detalles: detalles,
      esVideo: true,
    );
  }
}
