import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../styles/texts.dart';

class IngredientsDetail extends StatelessWidget {
  final List<Map<String, String>> ingredients;

  const IngredientsDetail({super.key, required this.ingredients});

  static const _googleUri = 'https://google.com/search';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredienti:',
          style: MemoText.subtitleDetail,
        ),
        const SizedBox(height: 10),
        // Verifica se ingredients è null o vuoto
        if (ingredients.isEmpty)
          const Text(
            'Nessun ingrediente disponibile',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          )
        else
          Wrap(
            spacing: 5.0,
            runSpacing: 20.0,
            children: ingredients.map((ingredient) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: GestureDetector(
                  onTap: () {
                    _launchWebSearch(ingredient['ingredient'] ?? '');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildMeasureText(ingredient['measure'] ?? ''),
                      AutoSizeText(
                        ingredient['ingredient'] ?? 'Ingrediente sconosciuto',
                        style: MemoText.ingredientName,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        maxFontSize: 20,
                        minFontSize: 14,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildMeasureText(String measure) {
    if (measure.toLowerCase().contains('tsp')) {
      int numTsp = int.tryParse(measure.toLowerCase().replaceAll('tsp', '').trim()) ?? 0;
      String teaspoonText = (numTsp == 1) ? 'cucchiaino' : 'cucchiaini';
      return AutoSizeText(
        minFontSize: 14,
        maxLines: 2,
        measure.replaceAll('tsp', teaspoonText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    } else if (measure.toLowerCase().contains('dash')) {
      return const AutoSizeText(
        'Riempi con',
        minFontSize: 14,
        maxLines: 2,
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    } else if (measure.toLowerCase().contains('part')) {
      if (measure.toLowerCase().contains('parts')) {
        return AutoSizeText(
          minFontSize: 14,
          maxLines: 2,
          measure.replaceAll('parts', 'parti'),
          style: MemoText.ingredientsMeasure,
          textAlign: TextAlign.center,
        );
      } else {
        return AutoSizeText(
          minFontSize: 14,
          maxLines: 2,
          measure.replaceAll('part', 'parte'),
          style: MemoText.ingredientsMeasure,
          textAlign: TextAlign.center,
        );
      }
    } else if (measure.toLowerCase().contains('tblsp')) {
      int numTbsp = int.tryParse(measure.toLowerCase().replaceAll('tblsp', '').trim()) ?? 0;
      String tablespoonText = (numTbsp == 1) ? 'cucchiaio' : 'cucchiai';
      return AutoSizeText(
        minFontSize: 14,
        maxLines: 2,
        measure.replaceAll('tblsp', tablespoonText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    } else {
      return AutoSizeText(
        minFontSize: 14,
        maxLines: 2,
        measure,
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    }
  }

  void _launchWebSearch(String ingredientName) async {
    final uri = Uri.parse('$_googleUri?q=$ingredientName');
    launch(
        uri.toString(),
        forceWebView: true,
        enableJavaScript: true,
        enableDomStorage: true
    );
  }
}
