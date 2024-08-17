import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/create_cocktail_card.dart';
import '../../models/cocktail.dart';

class CreatiDaMeTab extends StatefulWidget {
  const CreatiDaMeTab({super.key});

  @override
  _CreatiDaMeTabState createState() => _CreatiDaMeTabState();
}

class _CreatiDaMeTabState extends State<CreatiDaMeTab> {
  late Future<List<Cocktail>> _createdCocktails;

  @override
  void initState() {
    super.initState();
    _loadCocktails();
  }

  Future<void> _loadCocktails() async {
    setState(() {
      _createdCocktails = _getCreatedCocktails();
    });
  }

  Future<List<Cocktail>> _getCreatedCocktails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cocktailsJson = prefs.getStringList('cocktails') ?? [];
    return cocktailsJson
        .map((item) => Cocktail.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> _removeCocktail(Cocktail cocktail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cocktailsJson = prefs.getStringList('cocktails') ?? [];
    cocktailsJson.removeWhere((item) => Cocktail.fromJson(jsonDecode(item)).id == cocktail.id);
    await prefs.setStringList('cocktails', cocktailsJson);
    _loadCocktails(); // Ricarica la lista
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cocktail>>(
      future: _createdCocktails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nessun cocktail creato.'));
        }

        final cocktails = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: cocktails.length,
          itemBuilder: (context, index) {
            final cocktail = cocktails[index];
            return CreateCocktailCard(
              cocktail: cocktail,
              onDelete: () {
                _showConfirmationDialog(context, cocktail);
              },
            );
          },
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, Cocktail cocktail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rimuovere questo cocktail?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removeCocktail(cocktail);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: const Text('Rimuovi'),
            ),
          ],
        );
      },
    );
  }
}
