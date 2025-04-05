import 'package:flutter/material.dart';
import '../models/resultado_modelo.dart';
import 'package:share_plus/share_plus.dart';

class PantallaDetalles extends StatefulWidget {
  const PantallaDetalles({Key? key}) : super(key: key);

  @override
  State<PantallaDetalles> createState() => _PantallaDetallesState();
}

class _PantallaDetallesState extends State<PantallaDetalles> with SingleTickerProviderStateMixin {
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

  void _compartirDetalles(ResultadoModelo resultado) {
    final detallesText = resultado.detalles.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');
        
    Share.share(
      'Detalles técnicos del análisis realizado con FotoCheck:\n'
      'Resultado: ${resultado.tipoFormateado}\n'
      'Confianza: ${resultado.confianzaFormateada}\n\n'
      'DETALLES TÉCNICOS:\n$detallesText\n\n'
      'Fecha: ${DateTime.now().toString().substring(0, 16)}\n'
      '\nDescargue FotoCheck para analizar sus propias imágenes.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResultadoModelo resultado = ModalRoute.of(context)!.settings.arguments as ResultadoModelo;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles Técnicos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _compartirDetalles(resultado),
            tooltip: 'Compartir detalles',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resumen del resultado
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Color(int.parse(resultado.colorHexadecimal.replaceFirst('#', '0xFF'))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          resultado.tipo == 'IA' 
                              ? Icons.computer
                              : resultado.tipo == 'real' 
                                  ? Icons.check_circle
                                  : Icons.edit,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tipo: ${resultado.tipoFormateado}",
                                style: const TextStyle(
                                  fontSize: 20, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.white
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Confianza: ${resultado.confianzaFormateada}",
                                style: const TextStyle(
                                  fontSize: 16, 
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Título de características
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    "Características analizadas",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Lista de detalles técnicos
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resultado.detalles.length,
                  itemBuilder: (context, index) {
                    final entry = resultado.detalles.entries.elementAt(index);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          _formatKey(entry.key),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          entry.value is bool
                              ? (entry.value ? Icons.check_circle : Icons.cancel)
                              : Icons.info,
                          color: entry.value is bool
                              ? (entry.value ? Colors.green : Colors.red)
                              : Theme.of(context).primaryColor,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Valor: ${entry.value}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _getDescripcionCaracteristica(entry.key),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Información adicional
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
                              "Información adicional",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "El análisis de imágenes se basa en múltiples características y patrones que pueden indicar si una imagen es real, generada por IA o manipulada. "
                          "Los resultados pueden variar dependiendo de la calidad de la imagen y los métodos utilizados para su creación o manipulación.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Fecha del análisis: ${DateTime.now().toString().substring(0, 16)}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _compartirDetalles(resultado),
        tooltip: 'Compartir detalles',
        child: const Icon(Icons.share),
      ),
    );
  }
  
  String _formatKey(String key) {
    // Convertir snake_case o camelCase a palabras separadas y capitalizar
    final words = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    ).split('_');
    
    return words
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }
  
  String _getDescripcionCaracteristica(String key) {
    // Descripciones ficticias para las características
    final Map<String, String> descripciones = {
      'patron_repetitivo': 'Detecta patrones que se repiten de manera no natural en la imagen, típico de imágenes generadas por IA.',
      'inconsistencia_iluminacion': 'Analiza si la iluminación es consistente en toda la imagen o si hay áreas con iluminación contradictoria.',
      'artefactos_compresion': 'Identifica artefactos de compresión inusuales que pueden indicar manipulación digital.',
      'ruido_coherente': 'Evalúa si el ruido en la imagen es natural o si muestra patrones artificiales.',
      'textura_natural': 'Determina si las texturas en la imagen (piel, tela, superficies) tienen la variación natural esperada.',
      'bordes_artificiales': 'Detecta bordes demasiado perfectos o artificiales que no suelen aparecer en fotografías reales.',
      'metadata_intacta': 'Verifica si los metadatos de la imagen están intactos o han sido alterados.',
      'consistencia_perspectiva': 'Analiza si todos los elementos de la imagen siguen las mismas reglas de perspectiva.',
      'simetria_facial': 'En rostros, evalúa si hay una simetría facial inusualmente perfecta, típica de imágenes generadas por IA.',
      'detalle_excesivo': 'Identifica áreas con un nivel de detalle inconsistente con el resto de la imagen.',
    };
    
    // Devolver descripción o un mensaje genérico si no hay descripción específica
    return descripciones[key] ?? 
      'Esta característica es parte del análisis técnico para determinar la autenticidad de la imagen.';
  }
}
