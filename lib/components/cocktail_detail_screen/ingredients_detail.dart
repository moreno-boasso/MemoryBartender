import 'package:flutter/material.dart';

class IngredientsDetail extends StatelessWidget {
  final List<Map<String, String>> ingredients;

  const IngredientsDetail({super.key, required this.ingredients});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildMeasureText(ingredient['measure']!),
                  Text(
                    ingredient['ingredient']!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
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

      return Text(
        measure.replaceAll('tsp', teaspoonText),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      );
    } else if (measure.toLowerCase().contains('dash')) {
      // Sostituisci 'dash' con 'Riempi con'
      return const Text(
        'Riempi con',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      );
    } else if (measure.toLowerCase().contains('part')) {
      // Verifica se contiene 'part'
      if (measure.toLowerCase().contains('parts')) {
        // Se contiene 'parts', sostituisci con 'parti'
        return Text(
          measure.replaceAll('parts', 'parti'),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        );
      } else {
        // Altrimenti, sostituisci con 'parte'
        return Text(
          measure.replaceAll('part', 'parte'),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        );
      }
    } else if (measure.toLowerCase().contains('tblsp')) {
      // Estrai il numero di tbsp
      int numTbsp = int.tryParse(measure.toLowerCase().replaceAll('tblsp', '').trim()) ?? 0;

      // Determina la forma corretta di "cucchiaio da tavola" in base al numero
      String tablespoonText = (numTbsp == 1) ? 'cucchiaio' : 'cucchiai';

      return Text(
        measure.replaceAll('tblsp', tablespoonText),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      );
    } else {
      // Se non contiene 'tsp', 'dash', 'part' o 'tbsp', mostra la misura come è
      return Text(
        measure,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}
