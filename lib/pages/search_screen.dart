import 'package:flutter/material.dart';
import '../components/search_screen/search_bar.dart';
import '../models/cocktail.dart';
import '../components/search_screen/cocktail_grid.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';
import '../services/cocktail_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ScrollController _scrollController;
  late List<Cocktail> _cocktails;
  bool _isLoading = false;
  String _currentLetter = 'a';
  final CocktailService _cocktailService = CocktailService();
  bool _isManualSearch = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _cocktails = [];
    _fetchCocktails(_currentLetter);
  }

  Future<void> _fetchCocktails(String identifier) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final List<Cocktail> fetchedCocktails = await _cocktailService.getCocktailsByFirstLetter(identifier);
      setState(() {
        _cocktails.addAll(fetchedCocktails);
        _currentLetter = _cocktailService.getNextIdentifier(identifier);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading cocktails: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchCocktails(String query, String filter, bool isManualSearch) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _cocktails.clear();
      _isManualSearch = isManualSearch;
    });

    try {
      List<Cocktail> fetchedCocktails = [];
      if (filter == 'Nome') {
        fetchedCocktails = await _cocktailService.searchCocktailsByName(query);
      } else if (filter == 'Ingrediente') {
        fetchedCocktails = await _cocktailService.searchCocktailsByIngredient(query);
      }
      setState(() {
        _cocktails = fetchedCocktails;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error searching cocktails: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_isManualSearch) return;

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
        title: const Text('Cocktail Recipes', style: MemoText.titleScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomSearchBar(onSearch: _searchCocktails),
            const SizedBox(height: 10.0),
            Expanded(
              child: _cocktails.isEmpty && !_isLoading
                  ? const Center(
                child: Text('Nessun cocktail trovato'),
              )
                  : CocktailGrid(
                scrollController: _scrollController,
                cocktails: _cocktails,
                isLoading: _isLoading,
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: MemoColors.brownie),
              ),
          ],
        ),
      ),
    );
  }
}
