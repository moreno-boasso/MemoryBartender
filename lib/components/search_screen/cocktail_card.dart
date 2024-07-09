import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../pages/cocktail_detail_screen.dart';
import '../../styles/texts.dart';

class CocktailCard extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailCard({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CocktailDetailsPage(cocktailId: cocktail.id),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  cocktail.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    cocktail.name,
                    style: MemoText.titleCard,
                    maxLines: 1,
                    minFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico',
                    style: MemoText.alcoolCard,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
