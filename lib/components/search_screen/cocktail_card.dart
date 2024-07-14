import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/cocktail.dart';
import '../../pages/cocktail_detail_screen.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';
import 'card_preview.dart';

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
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CocktailDetailsDialog(cocktail: cocktail);
          },
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: MemoColors.black.withOpacity(0.4),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        color: Colors.white,
                      ),
                    ),
                    Image.network(
                      cocktail.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 140,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Shimmer.fromColors(
                            baseColor: MemoColors.beige,
                            highlightColor: MemoColors.beige,
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              color: MemoColors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ],
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
