import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
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
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isVideo = false;
  File? _archivo;

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
    
    // Inicialización diferida para acceder a los argumentos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inicializarArchivo();
    });
  }
  
  void _inicializarArchivo() {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _archivo = args['archivo'] as File;
    _isVideo = args['esVideo'] as bool;
    
    if (_isVideo) {
      _inicializarVideoController();
    }
  }
  
  void _inicializarVideoController() {
    _videoController = VideoPlayerController.file(_archivo!)
      ..initialize().then((_) {
        // Inicializar Chewie después de que el controlador de video esté listo
        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: true,
          looping: true,
          aspectRatio: _videoController!.value.aspectRatio,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                'Error al cargar el video: $errorMessage',
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _analizarArchivo() async {
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
      final resultado = _isVideo 
          ? await ApiServicioDemo().analizarVideo(_archivo!)
          : await ApiServicioDemo().analizarImagen(_archivo!);

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
        SnackBar(
          content: Text('Análisis de ${_isVideo ? 'video' : 'imagen'} completado exitosamente (Modo demostración)'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al analizar el ${_isVideo ? 'video' : 'imagen'}: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si _archivo es null, mostramos un indicador de carga
    if (_archivo == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isVideo ? 'Previsualización de Video' : 'Previsualización de Imagen'),
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
                        _isVideo ? 'Vista previa del video' : 'Vista previa de la imagen',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Hero(
                        tag: 'archivo_seleccionado',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _isVideo && _chewieController != null
                              ? AspectRatio(
                                  aspectRatio: _videoController!.value.aspectRatio,
                                  child: Chewie(controller: _chewieController!),
                                )
                              : _isVideo
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ImagenPrevisualizacion(imagen: _archivo!),
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
                          _isVideo ? 'Analizando video...' : 'Analizando imagen...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        BotonPersonalizado(
                          texto: _isVideo ? 'Analizar Video (Demo)' : 'Analizar Imagen (Demo)',
                          icono: Icons.search,
                          onPressed: _analizarArchivo,
                          color: _isVideo ? Colors.purple : null,
                        ),
                        const SizedBox(height: 16),
                        BotonPersonalizado(
                          texto: _isVideo ? 'Seleccionar otro video' : 'Seleccionar otra imagen',
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
