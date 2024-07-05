import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/cocktail.dart';

class CocktailService {
  final String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<List<Cocktail>> getCocktailsByFirstLetter(
      String letterOrNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search.php?f=$letterOrNumber'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> drinks = data['drinks'];

        List<Cocktail> cocktails = drinks.map((json) =>
            Cocktail(
              name: json['strDrink'],
              imageUrl: json['strDrinkThumb'],
              isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
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

}
