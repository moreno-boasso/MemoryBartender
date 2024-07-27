import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import 'cocktail_card.dart';

class CocktailGrid extends StatelessWidget {
  final ScrollController scrollController;
  final List<Cocktail> cocktails;
  final bool isLoading;

  const CocktailGrid({
    super.key,
    required this.scrollController,
    required this.cocktails,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 0.7,
        ),
        itemCount: cocktails.length,
        itemBuilder: (context, index) {
          return CocktailCard(cocktail: cocktails[index],);
        },
      ),
    );
  }
}
