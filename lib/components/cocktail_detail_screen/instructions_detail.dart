import 'package:flutter/material.dart';

class CocktailInstructions extends StatelessWidget {
  final String instructions;

  const CocktailInstructions({Key? key, required this.instructions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preparazione',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          instructions,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
