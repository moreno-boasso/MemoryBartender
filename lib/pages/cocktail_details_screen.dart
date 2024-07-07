import 'package:flutter/material.dart';
import '../../models/cocktail.dart';

class CocktailDetailsScreen extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetailsScreen({Key? key, required this.cocktail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                cocktail.imageUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(cocktail.ingredients.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '- ${cocktail.ingredients[index]}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Text(
                        cocktail.measures[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 8.0),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              cocktail.instructions,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Glass:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              cocktail.glass,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
