import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/resultado_modelo.dart';
import '../widgets/boton_personalizado.dart';
import '../routes/app_routes.dart';

class PantallaResultado extends StatefulWidget {
  const PantallaResultado({Key? key}) : super(key: key);
  
  @override
  State<PantallaResultado> createState() => _PantallaResultadoState();
}

class _PantallaResultadoState extends State<PantallaResultado> with SingleTickerProviderStateMixin {
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

  String _getInterpretacion(String tipo) {
    switch (tipo) {
      case 'IA':
        return 'Esta imagen muestra características típicas de imágenes generadas por inteligencia artificial. '
            'Los modelos de IA suelen dejar patrones reconocibles como inconsistencias en detalles faciales, '
            'fondos demasiado perfectos o artefactos visuales sutiles que nuestro algoritmo ha detectado.';
      case 'real':
        return 'Esta imagen presenta características consistentes con fotografías reales. '
            'No se detectaron los patrones típicos que dejan los generadores de imágenes por IA, '
            'ni tampoco signos de manipulación digital significativa.';
      case 'manipulada':
        return 'Esta imagen parece ser una fotografía real que ha sido alterada digitalmente. '
            'Se detectaron inconsistencias que sugieren edición, como cambios en la iluminación, '
            'bordes irregulares o patrones de clonación que no serían típicos en una imagen sin editar.';
      default:
        return 'No se pudo determinar con certeza el origen de esta imagen. '
            'Podría ser necesario un análisis más detallado para clasificarla correctamente.';
    }
  }

  String _getRecomendaciones(String tipo) {
    switch (tipo) {
      case 'IA':
        return 'Si vas a utilizar esta imagen, recuerda que es generada por IA y deberías: '
            '\n• Indicar claramente que es contenido generado por IA'
            '\n• Verificar si hay derechos de autor asociados al modelo de IA utilizado'
            '\n• Considerar las implicaciones éticas de su uso en ciertos contextos';
      case 'real':
        return 'Aunque esta imagen parece ser real, siempre es recomendable: '
            '\n• Verificar la fuente original de la imagen'
            '\n• Respetar los derechos de autor del fotógrafo'
            '\n• Considerar el contexto en el que se utilizará la imagen';
      case 'manipulada':
        return 'Al usar imágenes manipuladas, es importante: '
            '\n• Ser transparente sobre las ediciones realizadas'
            '\n• No presentarla como una imagen sin editar en contextos periodísticos'
            '\n• Considerar las implicaciones éticas de las modificaciones realizadas';
      default:
        return 'Ante la incertidumbre sobre el origen de esta imagen: '
            '\n• Busca fuentes adicionales para verificar su autenticidad'
            '\n• Utilízala con precaución en contextos donde la autenticidad es importante'
            '\n• Considera realizar un análisis más detallado si es necesario';
    }
  }

  void _compartirResultado(ResultadoModelo resultado) {
    Share.share(
      'Análisis de imagen realizado con FotoCheck:\n'
      'Resultado: ${resultado.tipoFormateado}\n'
      'Confianza: ${resultado.confianzaFormateada}\n'
      'Fecha: ${DateTime.now().toString().substring(0, 16)}\n'
      '\nDescargue FotoCheck para analizar sus propias imágenes.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResultadoModelo resultado = ModalRoute.of(context)!.settings.arguments as ResultadoModelo;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado del Análisis"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _compartirResultado(resultado),
            tooltip: 'Compartir resultado',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tarjeta principal con el resultado
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Color(int.parse(resultado.colorHexadecimal.replaceFirst('#', '0xFF'))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          resultado.tipo == 'IA' 
                              ? Icons.computer
                              : resultado.tipo == 'real' 
                                  ? Icons.check_circle
                                  : Icons.edit,
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          resultado.tipoFormateado,
                          style: const TextStyle(
                            fontSize: 28, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Confianza: ${resultado.confianzaFormateada}",
                          style: const TextStyle(
                            fontSize: 20, 
                            color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Interpretación
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, 
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Interpretación',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getInterpretacion(resultado.tipo),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Recomendaciones
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, 
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Recomendaciones',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getRecomendaciones(resultado.tipo),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Detalles técnicos expandibles
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.code, 
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        const Text('Detalles técnicos'),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: resultado.detalles.entries.map((entry) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(entry.key),
                                trailing: entry.value is bool
                                    ? Icon(
                                        entry.value ? Icons.check_circle : Icons.cancel,
                                        color: entry.value ? Colors.green : Colors.red,
                                      )
                                    : null,
                                subtitle: entry.value is! bool
                                    ? Text(entry.value.toString())
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: BotonPersonalizado(
                          texto: "Ver Detalles Completos",
                          icono: Icons.info_outline,
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.detalles, arguments: resultado);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      child: BotonPersonalizado(
                        texto: "Compartir",
                        icono: Icons.share,
                        onPressed: () => _compartirResultado(resultado),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BotonPersonalizado(
                        texto: "Analizar otra imagen",
                        icono: Icons.camera_alt,
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
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
