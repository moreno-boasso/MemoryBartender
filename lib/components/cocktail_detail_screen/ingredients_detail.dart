import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
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
    final measureLowerCase = measure.toLowerCase();

    if (measureLowerCase.contains('tsp')) {
      final numTsp = int.tryParse(measureLowerCase.replaceAll('tsp', '').trim()) ?? 0;
      final teaspoonText = numTsp == 1 ? 'cucchiaino' : 'cucchiaini';
      return AutoSizeText(
        measure.replaceAll('tsp', teaspoonText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
        minFontSize: 14,
        maxLines: 2,
      );
    } else if (measureLowerCase.contains('dash')) {
      return const AutoSizeText(
        'Riempi con',
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
        minFontSize: 14,
        maxLines: 2,
      );
    } else if (measureLowerCase.contains('part')) {
      final partText = measureLowerCase.contains('parts') ? 'parti' : 'parte';
      return AutoSizeText(
        measure.replaceAll('part', partText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
        minFontSize: 14,
        maxLines: 2,
      );
    } else if (measureLowerCase.contains('tblsp')) {
      final numTbsp = int.tryParse(measureLowerCase.replaceAll('tblsp', '').trim()) ?? 0;
      final tablespoonText = numTbsp == 1 ? 'cucchiaio' : 'cucchiai';
      return AutoSizeText(
        measure.replaceAll('tblsp', tablespoonText),
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
        minFontSize: 14,
        maxLines: 2,
      );
    } else {
      return AutoSizeText(
        measure,
        style: MemoText.ingredientsMeasure,
        textAlign: TextAlign.center,
        minFontSize: 14,
        maxLines: 2,
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
