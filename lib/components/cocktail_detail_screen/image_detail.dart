import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../styles/colors.dart';

class CocktailImageHeader extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailImageHeader({
    super.key,
    required this.cocktail,
  });

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height / 2;

    return Container(
      width: double.infinity,
      height: containerHeight,
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
        image: _buildImage(),
      ),
    );
  }

  DecorationImage _buildImage() {
    // Fallback to a placeholder image if the URL is empty
    final imageUrl = cocktail.imageUrl.isNotEmpty ? cocktail.imageUrl : 'https://via.placeholder.com/400x300';

    return DecorationImage(
      image: NetworkImage(imageUrl),
      fit: BoxFit.cover,
    );
  }
}
