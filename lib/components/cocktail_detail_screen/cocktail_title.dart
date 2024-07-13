import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../models/cocktail.dart';

class CocktailTitle extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailTitle({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5,
          height: 70,
          color: Colors.black,
          margin: const EdgeInsets.only(right: 8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: AutoSizeText(
                cocktail.name,
                maxFontSize: 30,
                minFontSize: 20,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
