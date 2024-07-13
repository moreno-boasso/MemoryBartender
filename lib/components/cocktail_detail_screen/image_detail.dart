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
          height: MediaQuery.of(context).size.height / 2.2,
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
          top: 20,
          left: 12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }
}
