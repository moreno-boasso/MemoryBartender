import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cocktail.dart';

class FavoritesService {
  static const String _daProvareKey = 'da_provare';
  static const String _fattoKey = 'fatto';

  Future<void> addToDaProvare(Cocktail cocktail) async {
    await _addCocktail(_daProvareKey, cocktail);
  }

  Future<void> addToFatto(Cocktail cocktail) async {
    await _addCocktail(_fattoKey, cocktail);
  }

  Future<void> removeFromDaProvare(String id) async {
    await _removeCocktail(_daProvareKey, id);
  }

  Future<void> removeFromFatto(String id) async {
    await _removeCocktail(_fattoKey, id);
  }

  Future<List<Cocktail>> getDaProvare() async {
    return await _getCocktails(_daProvareKey);
  }

  Future<List<Cocktail>> getFatto() async {
    return await _getCocktails(_fattoKey);
  }

  Future<bool> isCocktailInDaProvare(String id) async {
    return await _isCocktailInList(_daProvareKey, id);
  }

  Future<bool> isCocktailInFatto(String id) async {
    return await _isCocktailInList(_fattoKey, id);
  }

  // Funzione privata per aggiungere un cocktail alla lista appropriata
  Future<void> _addCocktail(String key, Cocktail cocktail) async {
    final List<Cocktail> cocktails = await _getCocktails(key);
    if (!cocktails.any((c) => c.id == cocktail.id)) {
      cocktails.add(cocktail);
      await _saveCocktails(key, cocktails);
    }
  }

  // Funzione privata per rimuovere un cocktail dalla lista appropriata
  Future<void> _removeCocktail(String key, String id) async {
    final List<Cocktail> cocktails = await _getCocktails(key);
    cocktails.removeWhere((cocktail) => cocktail.id == id);
    await _saveCocktails(key, cocktails);
  }

  // Funzione privata per ottenere i cocktail da una specifica lista
  Future<List<Cocktail>> _getCocktails(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String cocktailsString = prefs.getString(key) ?? '[]';
    final List<dynamic> cocktailsJson = jsonDecode(cocktailsString);
    return cocktailsJson.map((json) => Cocktail.fromJson(json)).toList();
  }

  // Funzione privata per salvare i cocktail in una specifica lista
  Future<void> _saveCocktails(String key, List<Cocktail> cocktails) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(cocktails.map((c) => c.toJson()).toList());
    await prefs.setString(key, encodedData);
  }

  // Funzione privata per verificare se un cocktail è in una specifica lista
  Future<bool> _isCocktailInList(String key, String id) async {
    final List<Cocktail> cocktails = await _getCocktails(key);
    return cocktails.any((cocktail) => cocktail.id == id);
  }
}
