import 'package:flutter/material.dart';

class BotonPersonalizado extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final IconData? icono;
  final Color? color;

  const BotonPersonalizado({
    Key? key,
    required this.texto, 
    required this.onPressed, 
    this.icono,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icono != null) ...[
            Icon(icono),
            const SizedBox(width: 8),
          ],
          Text(texto),
        ],
      ),
    );
  }
}
