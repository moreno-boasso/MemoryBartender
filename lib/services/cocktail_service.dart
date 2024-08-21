import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/cocktail.dart';

class CocktailService {
  final String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<List<Cocktail>> getCocktailsByFirstLetter(String letterOrNumber) async {
    return _fetchCocktails('$baseUrl/search.php?f=$letterOrNumber');
  }

  Future<List<Cocktail>> searchCocktailsByName(String name) async {
    return _fetchCocktails('$baseUrl/search.php?s=$name');
  }

  Future<List<Cocktail>> searchCocktailsByIngredient(String ingredient) async {
    return _fetchCocktails('$baseUrl/filter.php?i=$ingredient', withIngredients: false);
  }

  Future<Cocktail> getCocktailDetails(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final dynamic drink = data['drinks']?.isNotEmpty == true ? data['drinks'][0] : null;

        if (drink == null) {
          throw Exception('Cocktail not found');
        }

        return Cocktail(
          id: drink['idDrink'],
          name: drink['strDrink'],
          imageUrl: drink['strDrinkThumb'],
          isAlcoholic: drink['strAlcoholic'] == 'Alcoholic',
          ingredients: _getIngredients(drink),
          instructions: drink['strInstructions'] ?? 'Nessuna istruzione specificata..',
        );
      } else {
        throw Exception('Failed to load cocktail details');
      }
    } catch (e) {
      debugPrint('Error loading cocktail details: $e');
      throw Exception('Failed to load cocktail details: $e');
    }
  }

  Future<List<Cocktail>> _fetchCocktails(String url, {bool withIngredients = true}) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> drinks = data['drinks'] ?? [];

        return drinks.map((json) => Cocktail(
          id: json['idDrink'],
          name: json['strDrink'],
          imageUrl: json['strDrinkThumb'],
          isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
          ingredients: withIngredients ? _getIngredients(json) : [],
          instructions: '',
        )).toList();
      } else {
        throw Exception('Failed to load cocktails');
      }
    } catch (e) {
      debugPrint('Error loading cocktails: $e');
      throw Exception('Failed to load cocktails: $e');
    }
  }

  List<Map<String, String>> _getIngredients(dynamic drink) {
    List<Map<String, String>> ingredients = [];
    for (int i = 1; i <= 15; i++) {
      String? ingredient = drink['strIngredient$i'];
      String? measure = drink['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add({'ingredient': ingredient, 'measure': measure ?? ''});
      }
    }
    return ingredients;
  }

  String getNextIdentifier(String currentIdentifier) {
    int nextCodeUnit = currentIdentifier.codeUnitAt(0) + 1;

    // Salta 'u' e 'x' che sono vuoti
    while (nextCodeUnit == 117 || nextCodeUnit == 120) {
      nextCodeUnit++;
    }
    // Se il prossimo carattere è oltre 'z', ritorna ''
    if (nextCodeUnit > 122) {
      return '';
    } else {
      return String.fromCharCode(nextCodeUnit);
    }
  }
}
