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
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  cocktail.imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AutoSizeText(
                  cocktail.name,
                  textAlign: TextAlign.center,
                  style: MemoText.titleScreen,
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
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: MemoColors.white,
                  shape: BoxShape.circle,
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