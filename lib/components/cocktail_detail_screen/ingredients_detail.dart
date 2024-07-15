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
        Wrap(
          spacing: 5.0,
          runSpacing: 20.0,
          children: ingredients.map((ingredient) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 60) / 2,
              child: GestureDetector(
                onTap: () {
                  _launchWebSearch(ingredient['ingredient']!);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildMeasureText(ingredient['measure']!),
                    AutoSizeText(
                      '${ingredient['ingredient']}',
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
    // Verifica se la misura contiene 'tsp'
    if (measure.toLowerCase().contains('tsp')) {
      // Estrai il numero di tsp
      int numTsp = int.tryParse(measure.toLowerCase().replaceAll('tsp', '').trim()) ?? 0;

      // Determina la forma corretta di "cucchiaino" in base al numero
      String teaspoonText = (numTsp == 1) ? 'cucchiaino' : 'cucchiaini';

      return AutoSizeText(
        minFontSize: 14,
        maxLines: 2,
        measure.replaceAll('tsp', teaspoonText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    } else if (measure.toLowerCase().contains('dash')) {
      // Sostituisci 'dash' con 'Riempi con'
      return const AutoSizeText(
        'Riempi con',
        minFontSize: 14,
        maxLines: 2,
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    } else if (measure.toLowerCase().contains('part')) {
      // Verifica se contiene 'part'
      if (measure.toLowerCase().contains('parts')) {
        // Se contiene 'parts', sostituisci con 'parti'
        return AutoSizeText(
          minFontSize: 14,
          maxLines: 2,
          measure.replaceAll('parts', 'parti'),
          style: MemoText.ingredientsMeasure,
          textAlign: TextAlign.center,
        );
      } else {
        // Altrimenti, sostituisci con 'parte'
        return AutoSizeText(
          minFontSize: 14,
          maxLines: 2,
          measure.replaceAll('part', 'parte'),
          style: MemoText.ingredientsMeasure,
          textAlign: TextAlign.center,
        );
      }
    } else if (measure.toLowerCase().contains('tblsp')) {
      // Estrai il numero di tbsp
      int numTbsp = int.tryParse(measure.toLowerCase().replaceAll('tblsp', '').trim()) ?? 0;

      // Determina la forma corretta di "cucchiaio da tavola" in base al numero
      String tablespoonText = (numTbsp == 1) ? 'cucchiaio' : 'cucchiai';

      return AutoSizeText(
        minFontSize: 14,
        maxLines: 2,
        measure.replaceAll('tblsp', tablespoonText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
      );
    } else {
      // Se non contiene 'tsp', 'dash', 'part' o 'tbsp', mostra la misura come è
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
