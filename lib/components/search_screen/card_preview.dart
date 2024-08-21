import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../models/cocktail.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';

class CocktailDetailsDialog extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetailsDialog({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MemoColors.white,
      surfaceTintColor: MemoColors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.network(
                  cocktail.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,  // Fixed height for better appearance
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AutoSizeText(
                  cocktail.name,
                  textAlign: TextAlign.center,
                  style: MemoText.titleScreen,
                  maxFontSize: 20,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: MemoColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
