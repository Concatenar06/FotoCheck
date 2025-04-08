import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../routes/app_routes.dart';
import '../widgets/boton_personalizado.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({Key? key}) : super(key: key);
  
  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
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

  void _seleccionarImagen() async {
    if (kIsWeb) {
      // En web mostramos un mensaje informativo
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La funcionalidad completa no está disponible en la versión web. Por favor, utiliza la aplicación móvil o de escritorio.'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }
    
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.previsualizacion,
          arguments: {
            'archivo': File(image.path),
            'esVideo': false,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Imagen seleccionada correctamente'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al seleccionar la imagen: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _tomarFoto() async {
    if (kIsWeb) {
      // En web mostramos un mensaje informativo
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La funcionalidad completa no está disponible en la versión web. Por favor, utiliza la aplicación móvil o de escritorio.'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }
    
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null && mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.previsualizacion,
          arguments: {
            'archivo': File(image.path),
            'esVideo': false,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Foto tomada correctamente'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al tomar la foto: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
  
  void _seleccionarVideo() async {
    if (kIsWeb) {
      // En web mostramos un mensaje informativo
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La funcionalidad completa no está disponible en la versión web. Por favor, utiliza la aplicación móvil o de escritorio.'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }
    
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null && mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.previsualizacion,
          arguments: {
            'archivo': File(video.path),
            'esVideo': true,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video seleccionado correctamente'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al seleccionar el video: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
  
  void _grabarVideo() async {
    if (kIsWeb) {
      // En web mostramos un mensaje informativo
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La funcionalidad completa no está disponible en la versión web. Por favor, utiliza la aplicación móvil o de escritorio.'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }
    
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
      if (video != null && mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.previsualizacion,
          arguments: {
            'archivo': File(video.path),
            'esVideo': true,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video grabado correctamente'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al grabar el video: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('FotoCheck'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header con logo y descripción
                Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    height: 120,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '¿La imagen o video es real o generado por IA?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Sube una imagen o video para analizarlo y determinar si es real, generado por IA o manipulado digitalmente.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                
                // Sección de imágenes
                Text(
                  'Análisis de Imágenes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: BotonPersonalizado(
                        icono: Icons.photo_library,
                        texto: 'Seleccionar Imagen',
                        onPressed: _seleccionarImagen,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BotonPersonalizado(
                        icono: Icons.photo_camera,
                        texto: 'Tomar Foto',
                        onPressed: _tomarFoto,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 36),
                
                // Sección de videos
                Text(
                  'Análisis de Videos',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: BotonPersonalizado(
                        icono: Icons.video_library,
                        texto: 'Seleccionar Video',
                        onPressed: _seleccionarVideo,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BotonPersonalizado(
                        icono: Icons.videocam,
                        texto: 'Grabar Video',
                        onPressed: _grabarVideo,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                
                if (kIsWeb) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode 
                          ? Colors.amber.shade900.withAlpha(76) 
                          : Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isDarkMode ? Colors.amber.shade700 : Colors.amber.shade700),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.amber),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Nota: La versión web tiene funcionalidad limitada. Para una experiencia completa, utiliza la aplicación móvil o de escritorio.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: isDarkMode ? Colors.amber.shade300 : Colors.amber.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                ExpansionTile(
                  title: const Text('¿Cómo funciona?'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'FotoCheck utiliza algoritmos avanzados para analizar patrones en imágenes y videos, detectando si son reales, generados por IA o manipulados digitalmente. El análisis se basa en características como inconsistencias en iluminación, texturas no naturales, patrones repetitivos, estabilidad de cámara, sincronización de audio y otros indicadores de manipulación.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
