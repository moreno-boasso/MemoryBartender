import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../styles/colors.dart';

class CreatedCocktailImageHeader extends StatelessWidget {
  final Cocktail cocktail;

  const CreatedCocktailImageHeader({
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
        image: _buildBackgroundImage(),
      ),
    );
  }

  DecorationImage _buildBackgroundImage() {
    if (cocktail.imageUrl.isNotEmpty) {
      return DecorationImage(
        image: MemoryImage(_decodeBase64Image(cocktail.imageUrl)),
        fit: BoxFit.cover,
      );
    } else {
      return const DecorationImage(
        image: AssetImage('assets/images/placeholder.png'),
        fit: BoxFit.cover,
      );
    }
  }

  Uint8List _decodeBase64Image(String base64String) {
    return base64Decode(base64String);
  }
}
