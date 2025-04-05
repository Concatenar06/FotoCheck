import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImagenPrevisualizacion extends StatelessWidget {
  final File imagen;

  const ImagenPrevisualizacion({Key? key, required this.imagen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // En la web no podemos usar Image.file directamente
    if (kIsWeb) {
      return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Vista previa no disponible en web',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    } else {
      // En dispositivos móviles y escritorio podemos usar Image.file
      return Image.file(
        imagen,
        width: 300,
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }
}
