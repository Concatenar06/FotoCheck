import 'package:flutter/material.dart';
import '../screens/pantalla_inicio.dart';
import '../screens/pantalla_previsualizacion.dart';
import '../screens/pantalla_resultado.dart';
import '../screens/pantalla_detalles.dart';

// Definición de rutas para la navegación de la aplicación
final Map<String, WidgetBuilder> appRoutes = {
  '/': (BuildContext context) => const PantallaInicio(),
  '/previsualizacion': (BuildContext context) => const PantallaPrevisualizacion(),
  '/resultado': (BuildContext context) => const PantallaResultado(),
  '/detalles': (BuildContext context) => const PantallaDetalles(),
};

// Clase con constantes para las rutas (útil para la navegación)
class AppRoutes {
  static const String inicio = '/';
  static const String previsualizacion = '/previsualizacion';
  static const String resultado = '/resultado';
  static const String detalles = '/detalles';
}
