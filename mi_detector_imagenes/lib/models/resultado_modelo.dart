class ResultadoModelo {
  final String tipo;
  final double confianza;
  final Map<String, dynamic> detalles;
  final String? _colorHexadecimal; // Color personalizado opcional

  ResultadoModelo({
    required this.tipo, 
    required this.confianza, 
    required this.detalles,
    String? colorHexadecimal,
  }) : _colorHexadecimal = colorHexadecimal;

  factory ResultadoModelo.fromJson(Map<String, dynamic> json) {
    return ResultadoModelo(
      tipo: json['tipo'],
      confianza: json['confianza'].toDouble(),
      detalles: json['detalles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'confianza': confianza,
      'detalles': detalles,
    };
  }

  String get tipoFormateado {
    switch (tipo) {
      case 'IA':
        return 'Generada por IA';
      case 'real':
        return 'Imagen Real';
      case 'manipulada':
        return 'Imagen Manipulada';
      default:
        return 'Desconocido';
    }
  }

  String get confianzaFormateada {
    return '${confianza.toStringAsFixed(1)}%';
  }

  String get colorHexadecimal {
    // Si se proporcionó un color personalizado, lo usamos
    if (_colorHexadecimal != null) {
      return _colorHexadecimal!;
    }
    
    // De lo contrario, usamos los colores predeterminados
    switch (tipo) {
      case 'IA':
        return '#2196F3'; // Azul
      case 'real':
        return '#4CAF50'; // Verde
      case 'manipulada':
        return '#FF9800'; // Naranja
      default:
        return '#9E9E9E'; // Gris
    }
  }
}
