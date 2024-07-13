import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/cocktail.dart';

class CocktailService {
  final String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<List<Cocktail>> getCocktailsByFirstLetter(String letterOrNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search.php?f=$letterOrNumber'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> drinks = data['drinks'];

        List<Cocktail> cocktails = drinks.map((json) => Cocktail(
          id: json['idDrink'],
          name: json['strDrink'],
          imageUrl: json['strDrinkThumb'],
          isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
          ingredients: _getIngredients(json),
          instructions: '', // Nessuna istruzione specifica per la ricerca per lettera
        )).toList();
        return cocktails;
      } else {
        throw Exception('Failed to load cocktails');
      }
    } catch (e) {
      debugPrint('Error loading cocktails: $e');
      throw Exception('Failed to load cocktails: $e');
    }
  }

  Future<List<Cocktail>> searchCocktailsByName(String name) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/search.php?s=$name'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> drinks = data['drinks'];

        List<Cocktail> cocktails = drinks.map((json) => Cocktail(
          id: json['idDrink'],
          name: json['strDrink'],
          imageUrl: json['strDrinkThumb'],
          isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
          ingredients: _getIngredients(json),
          instructions: '', // Nessuna istruzione specifica per la ricerca per nome
        )).toList();
        return cocktails;
      } else {
        throw Exception('Failed to load cocktails');
      }
    } catch (e) {
      debugPrint('Error loading cocktails: $e');
      throw Exception('Failed to load cocktails: $e');
    }
  }

  Future<List<Cocktail>> searchCocktailsByIngredient(String ingredient) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/filter.php?i=$ingredient'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> drinks = data['drinks'];

        List<Cocktail> cocktails = drinks.map((json) => Cocktail(
          id: json['idDrink'],
          name: json['strDrink'],
          imageUrl: json['strDrinkThumb'],
          isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
          ingredients: [], // filter.php non fornisce ingredienti
          instructions: '', // Nessuna istruzione specifica per la ricerca per ingrediente
        )).toList();
        return cocktails;
      } else {
        throw Exception('Failed to load cocktails');
      }
    } catch (e) {
      debugPrint('Error loading cocktails: $e');
      throw Exception('Failed to load cocktails: $e');
    }
  }


  Future<Cocktail> getCocktailDetails(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final dynamic drink = data['drinks'][0];

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
