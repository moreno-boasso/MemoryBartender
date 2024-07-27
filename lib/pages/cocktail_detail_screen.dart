import 'package:flutter/material.dart';
import '../components/cocktail_detail_screen/conversion_detail.dart';
import '../components/cocktail_detail_screen/favourite_button.dart';
import '../components/cocktail_detail_screen/image_detail.dart';
import '../components/cocktail_detail_screen/cocktail_title.dart';
import '../components/cocktail_detail_screen/instructions_detail.dart';
import '../components/cocktail_detail_screen/ingredients_detail.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';
import '../styles/colors.dart';

class CocktailDetailsPage extends StatelessWidget {
  final String cocktailId;

  const CocktailDetailsPage({super.key, required this.cocktailId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cocktail>(
      future: CocktailService().getCocktailDetails(cocktailId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: MemoColors.brownie),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data'));
        }

        final cocktail = snapshot.data!;

        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CocktailImageHeader(cocktail: cocktail),

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
                FavoriteButton(cocktail: cocktail),
                Positioned(
                  top: 20,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true); // Passa `true` per indicare che ci sono stati cambiamenti
                    },
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
                        color: MemoColors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
