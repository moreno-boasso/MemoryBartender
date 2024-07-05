import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/search_screen/search_bar.dart';
import '../models/cocktail.dart';
import '../components/search_screen/cocktail_grid.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController _scrollController;
  late List<Cocktail> _cocktails;
  late bool _isLoading;
  late String _currentLetter;
  final String _baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _cocktails = [];
    _isLoading = false;
    _currentLetter = 'a';
    _fetchCocktails(_currentLetter);
  }

  Future<void> _fetchCocktails(String identifier) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search.php?f=$identifier'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> drinks = data['drinks'];

        List<Cocktail> fetchedCocktails = drinks.map((json) =>
            Cocktail(
              name: json['strDrink'],
              imageUrl: json['strDrinkThumb'],
              isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
            )).toList();

        setState(() {
          _cocktails.addAll(fetchedCocktails);
          _currentLetter = _getNextIdentifier(identifier);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load cocktails');
      }
    } catch (e) {
      debugPrint('Error loading cocktails: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getNextIdentifier(String currentIdentifier) {
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

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchCocktails(_currentLetter);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: MemoColors.white,
        title: const Text('Cocktail Recipes',style: MemoText.titleScreen,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CustomSearchBar(),
            const SizedBox(height: 10.0),
            Expanded(
              child: CocktailGrid(
                scrollController: _scrollController,
                cocktails: _cocktails,
                isLoading: _isLoading,
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
