import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../models/cocktail.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';

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
          height: 63,
          color: MemoColors.brownie,
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
                minFontSize: 20,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: MemoText.titleDetail,
              ),
            ),
            Text(
              cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico',
              style: MemoText.alcoolDetail
            ),
          ],
        ),
      ],
    );
  }
}
