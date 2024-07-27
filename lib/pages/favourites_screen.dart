import 'package:flutter/material.dart';
import '../components/search_screen/cocktail_card.dart';
import '../../services/favorite_service.dart';
import '../../models/cocktail.dart';
import 'favourite_tabs/created_tab.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Cocktail>> _daProvareCocktails;
  late Future<List<Cocktail>> _fattoCocktails;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _daProvareCocktails = FavoritesService().getDaProvare();
      _fattoCocktails = FavoritesService().getFatto();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: 'Da Provare', icon: Icon(Icons.access_time)),
            Tab(text: 'Fatto', icon: Icon(Icons.check)),
            Tab(text: 'Creati da me', icon: Icon(Icons.account_circle)),
          ],
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Cocktail>>(
              future: _daProvareCocktails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nessun cocktail da provare'));
                }

                final cocktails = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: cocktails.length,
                  itemBuilder: (context, index) {
                    return CocktailCard(cocktail: cocktails[index]);
                  },
                );
              },
            ),
            FutureBuilder<List<Cocktail>>(
              future: _fattoCocktails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nessun cocktail fatto'));
                }

                final cocktails = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: cocktails.length,
                  itemBuilder: (context, index) {
                    return CocktailCard(cocktail: cocktails[index]);
                  },
                );
              },
            ),
            CreatiDaMeTab(), // Se hai una tab per i cocktail creati da te
          ],
        ),
      ),
    );
  }
}
