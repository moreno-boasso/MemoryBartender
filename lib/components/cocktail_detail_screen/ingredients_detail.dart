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
                  Text(
                    ingredient['measure']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.start,
                  ),
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
}
