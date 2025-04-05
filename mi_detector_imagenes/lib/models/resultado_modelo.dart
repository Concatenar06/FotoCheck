class ResultadoModelo {
  final String tipo;
  final double confianza;
  final Map<String, dynamic> detalles;

  ResultadoModelo({required this.tipo, required this.confianza, required this.detalles});

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
    switch (tipo) {
      case 'IA':
        return '#FF5733'; // Rojo
      case 'real':
        return '#33FF57'; // Verde
      case 'manipulada':
        return '#FFDD33'; // Amarillo
      default:
        return '#AAAAAA'; // Gris
    }
  }
}
