import 'package:flutter/material.dart';
import '../components/cocktail_detail_screen/conversion_detail.dart';
import '../components/cocktail_detail_screen/image_detail.dart';
import '../components/cocktail_detail_screen/cocktail_title.dart';
import '../components/cocktail_detail_screen/instructions_detail.dart';
import '../components/cocktail_detail_screen/ingredients_detail.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';
import '../styles/colors.dart'; // Assicurati di importare i tuoi colori

class CocktailDetailsPage extends StatefulWidget {
  final String cocktailId;

  const CocktailDetailsPage({super.key, required this.cocktailId});

  @override
  _CocktailDetailsPageState createState() => _CocktailDetailsPageState();
}

class _CocktailDetailsPageState extends State<CocktailDetailsPage> {
  bool _isFavorited = false; // Variabile di stato per gestire il colore

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
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 26,
                  right: 25,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorited = !_isFavorited;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isFavorited ? Colors.red : MemoColors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite_border_sharp,
                          color: _isFavorited ? Colors.white : MemoColors.black,
                          size: 25,
                        ),
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
