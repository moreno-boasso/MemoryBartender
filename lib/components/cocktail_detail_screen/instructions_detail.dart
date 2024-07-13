import 'package:flutter/material.dart';

import '../../styles/texts.dart';

class CocktailInstructions extends StatelessWidget {
  final String instructions;

  const CocktailInstructions({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Istruzioni:',
          style: MemoText.subtitleDetail
        ),
        const SizedBox(height: 7),
        Text(
          instructions,
            style: MemoText.instructionsText
        ),
      ],
    );
  }
}
