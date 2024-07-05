import 'package:flutter/material.dart';

import '../../models/cocktail.dart';

class CocktailCard extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailCard({required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Text(
                    cocktail.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      // Azione quando si preme il pulsante "Vedi Cocktail"
                    },
                    child: const Text('Vedi Cocktail'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                cocktail.imageUrl,
                width: 150,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
