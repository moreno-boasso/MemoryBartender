import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../pages/created_cocktail_detail_screen.dart';

class CreateCocktailCard extends StatelessWidget {
  final Cocktail cocktail;
  final VoidCallback onDelete;

  const CreateCocktailCard({
    required this.cocktail,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatedCocktailDetailsPage(cocktail: cocktail), // Passa il cocktail
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mostra l'immagine solo se è presente
                cocktail.imageUrl.isNotEmpty
                    ? Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: Image.memory(
                      base64Decode(cocktail.imageUrl),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 140,
                    ),
                  ),
                )
                    : Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[600],
                      size: 50,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cocktail.name ?? 'Unnamed Cocktail',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    cocktail.isAlcoholic != null ? (cocktail.isAlcoholic! ? 'Alcolico' : 'Analcolico') : 'Unknown',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 8.0), // Spazio tra il testo e il bordo inferiore
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
