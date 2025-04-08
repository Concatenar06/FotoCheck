import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../routes/app_routes.dart';
import '../widgets/imagen_previsualizacion.dart';
import '../widgets/boton_personalizado.dart';
import '../services/api_servicio_demo.dart'; // Cambiado a la versión de demostración

class PantallaPrevisualizacion extends StatefulWidget {
  const PantallaPrevisualizacion({Key? key}) : super(key: key);

  @override
  State<PantallaPrevisualizacion> createState() =>
      _PantallaPrevisualizacionState();
}

class _PantallaPrevisualizacionState extends State<PantallaPrevisualizacion>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _analizarImagen(File imagen) async {
    if (kIsWeb) {
      // En web mostramos un mensaje informativo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'La funcionalidad de análisis no está disponible en la versión web. Por favor, utiliza la aplicación móvil o de escritorio.'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Usamos el servicio de demostración que no requiere conexión al backend
      final resultado = await ApiServicioDemo().analizarImagen(imagen);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.pushNamed(
        context,
        AppRoutes.resultado,
        arguments: resultado,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Análisis completado exitosamente (Modo demostración)'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al analizar la imagen: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final File imagen = ModalRoute.of(context)!.settings.arguments as File;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsualización'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Vista previa de la imagen',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Hero(
                        tag: 'imagen_seleccionada',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ImagenPrevisualizacion(imagen: imagen),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Analizando imagen...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        BotonPersonalizado(
                          texto: 'Analizar Imagen (Demo)',
                          icono: Icons.search,
                          onPressed: () => _analizarImagen(imagen),
                        ),
                        const SizedBox(height: 16),
                        BotonPersonalizado(
                          texto: 'Seleccionar otra imagen',
                          icono: Icons.arrow_back,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
              const SizedBox(height: 16),
              if (kIsWeb)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.amber.shade900.withAlpha(76)
                        : Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: isDarkMode
                            ? Colors.amber.shade700
                            : Colors.amber.shade700),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'La funcionalidad de análisis no está disponible en la versión web. Por favor, utiliza la aplicación móvil o de escritorio.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.amber.shade300
                                : Colors.amber.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              // Nota de demostración
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.blue.shade900.withAlpha(76)
                      : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: isDarkMode
                          ? Colors.blue.shade700
                          : Colors.blue.shade700),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'VERSIÓN DE DEMOSTRACIÓN: Esta versión genera resultados aleatorios y no requiere conexión a un servidor backend.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.blue.shade300
                              : Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
