import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../services/favorite_service.dart';
import '../../components/search_screen/cocktail_card.dart';

class DaProvareTab extends StatefulWidget {
  const DaProvareTab({super.key});

  @override
  _DaProvareTabState createState() => _DaProvareTabState();
}

class _DaProvareTabState extends State<DaProvareTab> {
  late Future<List<Cocktail>> _daProvareCocktails;

  @override
  void initState() {
    super.initState();
    _loadCocktails();
  }

  Future<void> _loadCocktails() async {
    setState(() {
      _daProvareCocktails = FavoritesService().getDaProvare();
    });
  }

  Future<void> _removeCocktail(Cocktail cocktail) async {
    await FavoritesService().removeFromDaProvare(cocktail.id);
    _loadCocktails(); // Ricarica la lista
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cocktail>>(
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
            return Stack(
              children: [
                CocktailCard(cocktail: cocktails[index],), // Non cambia
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeCocktail(cocktails[index]),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
class FattoTab extends StatefulWidget {
  const FattoTab({super.key});

  @override
  _FattoTabState createState() => _FattoTabState();
}

class _FattoTabState extends State<FattoTab> {
  late Future<List<Cocktail>> _fattoCocktails;

  @override
  void initState() {
    super.initState();
    _loadCocktails();
  }

  Future<void> _loadCocktails() async {
    setState(() {
      _fattoCocktails = FavoritesService().getFatto();
    });
  }

  Future<void> _removeCocktail(Cocktail cocktail) async {
    await FavoritesService().removeFromFatto(cocktail.id);
    _loadCocktails(); // Ricarica la lista
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cocktail>>(
      future: _fattoCocktails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nessun cocktail provato'));
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
            return Stack(
              children: [
                CocktailCard(cocktail: cocktails[index],), // Non cambia
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeCocktail(cocktails[index]),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}