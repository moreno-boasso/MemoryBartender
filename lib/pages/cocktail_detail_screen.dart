import 'package:flutter/material.dart';
import 'package:memory_bartender/styles/colors.dart';
import '../components/cocktail_detail_screen/conversion_detail.dart';
import '../components/cocktail_detail_screen/favourite_button.dart';
import '../components/cocktail_detail_screen/image_detail.dart';
import '../components/cocktail_detail_screen/cocktail_title.dart';
import '../components/cocktail_detail_screen/instructions_detail.dart';
import '../components/cocktail_detail_screen/ingredients_detail.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';

class CocktailDetailsPage extends StatefulWidget {
  final String cocktailId;

  const CocktailDetailsPage({super.key, required this.cocktailId});

  @override
  _CocktailDetailsPageState createState() => _CocktailDetailsPageState();
}

class _CocktailDetailsPageState extends State<CocktailDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cocktail>(
      future: CocktailService().getCocktailDetails(widget.cocktailId),
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
                          // Titolo del cocktail
                          CocktailTitle(cocktail: cocktail),

                          const SizedBox(height: 30),

                          // Ingredienti
                          IngredientsDetail(ingredients: cocktail.ingredients),

                          const SizedBox(height: 40),

                          // Preparazione
                          CocktailInstructions(instructions: cocktail.instructions),

                          const SizedBox(height: 10),

                          ConversionSection(cocktail: cocktail),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                const FavoriteButton(),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
