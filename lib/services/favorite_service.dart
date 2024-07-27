import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cocktail.dart';

class FavoritesService {
  static const String _daProvareKey = 'da_provare';
  static const String _fattoKey = 'fatto';

  Future<void> addToDaProvare(Cocktail cocktail) async {
    final prefs = await SharedPreferences.getInstance();
    final daProvare = await getDaProvare();
    if (!daProvare.any((c) => c.id == cocktail.id)) {
      daProvare.add(cocktail);
      prefs.setString(_daProvareKey, jsonEncode(daProvare.map((e) => e.toJson()).toList()));
    }
  }

  Future<void> addToFatto(Cocktail cocktail) async {
    final prefs = await SharedPreferences.getInstance();
    final fatto = await getFatto();
    if (!fatto.any((c) => c.id == cocktail.id)) {
      fatto.add(cocktail);
      prefs.setString(_fattoKey, jsonEncode(fatto.map((e) => e.toJson()).toList()));
    }
  }

  Future<void> removeFromDaProvare(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final daProvare = await getDaProvare();
    daProvare.removeWhere((cocktail) => cocktail.id == id);
    prefs.setString(_daProvareKey, jsonEncode(daProvare.map((e) => e.toJson()).toList()));
  }

  Future<void> removeFromFatto(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final fatto = await getFatto();
    fatto.removeWhere((cocktail) => cocktail.id == id);
    prefs.setString(_fattoKey, jsonEncode(fatto.map((e) => e.toJson()).toList()));
  }

  Future<List<Cocktail>> getDaProvare() async {
    final prefs = await SharedPreferences.getInstance();
    final daProvareString = prefs.getString(_daProvareKey) ?? '[]';
    final List<dynamic> daProvareJson = jsonDecode(daProvareString);
    return daProvareJson.map((json) => Cocktail.fromJson(json)).toList();
  }

  Future<List<Cocktail>> getFatto() async {
    final prefs = await SharedPreferences.getInstance();
    final fattoString = prefs.getString(_fattoKey) ?? '[]';
    final List<dynamic> fattoJson = jsonDecode(fattoString);
    return fattoJson.map((json) => Cocktail.fromJson(json)).toList();
  }

  Future<bool> isCocktailInDaProvare(String id) async {
    final daProvare = await getDaProvare();
    return daProvare.any((cocktail) => cocktail.id == id);
  }

  Future<bool> isCocktailInFatto(String id) async {
    final fatto = await getFatto();
    return fatto.any((cocktail) => cocktail.id == id);
  }
}
