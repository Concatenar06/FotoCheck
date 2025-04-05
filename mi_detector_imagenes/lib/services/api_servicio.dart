import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../models/resultado_modelo.dart';

class ApiServicio {
  // URL base para diferentes plataformas
  String get _baseUrl {
    // En Android emulador, necesitamos usar 10.0.2.2 para acceder al localhost de la máquina host
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    }
    // Para otras plataformas, usamos localhost
    return 'http://127.0.0.1:8000';
  }

  /// Envía una imagen al servidor para su análisis
  Future<ResultadoModelo> analizarImagen(File imagen) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/analizar-imagen/'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', imagen.path),
      );
      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(respStr);
        return ResultadoModelo.fromJson(jsonResponse);
      } else {
        throw Exception('Error al analizar la imagen: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la comunicación con el servidor: $e');
    }
  }
}
