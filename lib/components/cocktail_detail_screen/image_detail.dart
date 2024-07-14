import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../styles/colors.dart';

class CocktailImageHeader extends StatelessWidget {
  final Cocktail cocktail;
  final BuildContext context;

  const CocktailImageHeader({super.key, required this.cocktail, required this.context});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: MemoColors.black.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(cocktail.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 25,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: MemoColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: MemoColors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }
}
