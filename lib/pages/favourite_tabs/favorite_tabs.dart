import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../services/favorite_service.dart';
import '../../components/search_screen/cocktail_card.dart';

class DaProvareTab extends StatelessWidget {
  const DaProvareTab({super.key});

  @override
  Widget build(BuildContext context) {
    return _CocktailTab(
      fetchCocktails: () => FavoritesService().getDaProvare(),
      onRemoveCocktail: (cocktail) async {
        await FavoritesService().removeFromDaProvare(cocktail.id);
      },
      emptyMessage: 'Nessun cocktail salvato.',
    );
  }
}

class FattoTab extends StatelessWidget {
  const FattoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return _CocktailTab(
      fetchCocktails: () => FavoritesService().getFatto(),
      onRemoveCocktail: (cocktail) async {
        await FavoritesService().removeFromFatto(cocktail.id);
      },
      emptyMessage: 'Nessun cocktail salvato.',
    );
  }
}

class _CocktailTab extends StatefulWidget {
  final Future<List<Cocktail>> Function() fetchCocktails;
  final Future<void> Function(Cocktail) onRemoveCocktail;
  final String emptyMessage;

  const _CocktailTab({
    required this.fetchCocktails,
    required this.onRemoveCocktail,
    required this.emptyMessage,
  });

  @override
  __CocktailTabState createState() => __CocktailTabState();
}

class __CocktailTabState extends State<_CocktailTab> {
  late Future<List<Cocktail>> _cocktailsFuture;

  @override
  void initState() {
    super.initState();
    _loadCocktails();
  }

  Future<void> _loadCocktails() async {
    setState(() {
      _cocktailsFuture = widget.fetchCocktails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CocktailGrid(
      futureCocktails: _cocktailsFuture,
      onRemoveCocktail: (cocktail) async {
        await widget.onRemoveCocktail(cocktail);
        _loadCocktails(); // Ricarica la lista dopo la rimozione
      },
      emptyMessage: widget.emptyMessage,
    );
  }
}

class CocktailGrid extends StatelessWidget {
  final Future<List<Cocktail>> futureCocktails;
  final Future<void> Function(Cocktail) onRemoveCocktail;
  final String emptyMessage;

  const CocktailGrid({
    Key? key,
    required this.futureCocktails,
    required this.onRemoveCocktail,
    required this.emptyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cocktail>>(
      future: futureCocktails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(emptyMessage));
        }

        final cocktails = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GridView.builder(
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
                  CocktailCard(cocktail: cocktails[index]),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showConfirmationDialog(context, cocktails[index]),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, Cocktail cocktail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rimuovere dai preferiti?'),
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
                onRemoveCocktail(cocktail);
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
