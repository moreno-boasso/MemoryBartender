import 'package:flutter/material.dart';
import '../components/search_screen/cocktail_card.dart';
import '../components/search_screen/search_bar.dart';
import '../models/cocktail.dart'; // Importa il modello Cocktail
import '../styles/texts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  // Metodo fittizio per ottenere una lista di cocktail (sostituiscilo con la tua logica reale)
  List<Cocktail> fetchCocktails() {
    return [
      Cocktail(name: 'Margarita', imageUrl: 'assets/images/margarita.jpeg'),
      Cocktail(name: 'Martini', imageUrl: 'assets/images/martini.jpeg'),
      Cocktail(name: 'Margarita', imageUrl: 'assets/images/margarita.jpeg'),
      Cocktail(name: 'Martini', imageUrl: 'assets/images/martini.jpeg'),
      Cocktail(name: 'Margarita', imageUrl: 'assets/images/margarita.jpeg'),
      Cocktail(name: 'Martini', imageUrl: 'assets/images/martini.jpeg'),
      // Aggiungi altri cocktail qui
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Cocktail> cocktails = fetchCocktails();

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Cocktail Recipes',
              style: MemoText.titleScreen,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10.0),
            CustomSearchBar(),
            SizedBox(height: 15.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: cocktails.map((cocktail) {
                    return CocktailCard(cocktail: cocktail);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
