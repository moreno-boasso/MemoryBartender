import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';

class CocktailDetailsPage extends StatelessWidget {
  final String cocktailId;

  CocktailDetailsPage({required this.cocktailId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cocktail>(
      future: CocktailService().getCocktailDetails(cocktailId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data'));
        }

        final cocktail = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immagine del drink
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(cocktail.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Titolo e Alcolico/Analcolico
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5,
                      height: 50,
                      color: Colors.black,
                      margin: EdgeInsets.only(left: 16, right: 8),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cocktail.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Ingredienti
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingredienti',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ...cocktail.ingredients.map((ingredient) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ingredient['measure']!,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              ingredient['ingredient']!,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      }).toList(),
                      SizedBox(height: 20),

                      // Preparazione
                      Text(
                        'Preparazione',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        cocktail.instructions,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),

                      Text(
                        'Tipo di bicchiere',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
// Tipo di bicchiere
                      Text(
                        cocktail.glassType,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
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
