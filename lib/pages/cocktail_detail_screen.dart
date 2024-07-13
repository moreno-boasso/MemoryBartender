import 'package:flutter/material.dart';
import '../components/cocktail_detail_screen/conversion_detail.dart';
import '../components/cocktail_detail_screen/image_detail.dart';
import '../components/cocktail_detail_screen/cocktail_title.dart';
import '../components/cocktail_detail_screen/instructions_detail.dart';
import '../components/cocktail_detail_screen/ingredients_detail.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';

class CocktailDetailsPage extends StatefulWidget {
  final String cocktailId;

  const CocktailDetailsPage({Key? key, required this.cocktailId}) : super(key: key);

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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data'));
        }

        final cocktail = snapshot.data!;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immagine del cocktail
                CocktailImageHeader(cocktail: cocktail, context: context),

                const SizedBox(height: 30),

                // Padding generale per il contenuto
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

                      const SizedBox(height: 30),

                      // Preparazione
                      CocktailInstructions(instructions: cocktail.instructions),

                      const SizedBox(height: 30),

                      ConversionSection(cocktail: cocktail), // Utilizza il nuovo componente
                    ],
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
