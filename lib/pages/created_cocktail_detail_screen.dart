import 'package:flutter/material.dart';
import 'package:memory_bartender/components/cocktail_detail_screen/create_image_detail.dart';
import '../components/cocktail_detail_screen/conversion_detail.dart';
import '../components/cocktail_detail_screen/cocktail_title.dart';
import '../components/cocktail_detail_screen/instructions_detail.dart';
import '../components/cocktail_detail_screen/ingredients_detail.dart';
import '../models/cocktail.dart';

class CreatedCocktailDetailsPage extends StatelessWidget {
  final Cocktail cocktail;

  const CreatedCocktailDetailsPage({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cocktail.imageUrl.isNotEmpty
                    ? CreatedCocktailImageHeader(cocktail: cocktail)
                    : SizedBox(
                  width: double.infinity,
                  height: screenHeight / 2,
                  child: Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text(
                        'Nessuna Immagine',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CocktailTitle(cocktail: cocktail),
                      const SizedBox(height: 30),
                      IngredientsDetail(ingredients: cocktail.ingredients),
                      const SizedBox(height: 40),
                      CocktailInstructions(instructions: cocktail.instructions),
                      const SizedBox(height: 10),
                      ConversionSection(cocktail: cocktail),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
