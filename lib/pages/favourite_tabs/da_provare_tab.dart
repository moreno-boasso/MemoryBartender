import 'package:flutter/material.dart';
import '../../components/search_screen/cocktail_card.dart';
import '../../models/cocktail.dart';
import '../../services/favorite_service.dart';
import '../cocktail_detail_screen.dart';

class DaProvareTab extends StatelessWidget {
  const DaProvareTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cocktail>>(
      future: FavoritesService().getDaProvare(),
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
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CocktailDetailsPage(
                      cocktailId: cocktails[index].id,
                      onUpdate: () {
                        // Callback per ricaricare i dati
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                );
              },
              child: CocktailCard(cocktail: cocktails[index]),
            );
          },
        );
      },
    );
  }
}

class FattoTab extends StatelessWidget {
  const FattoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cocktail>>(
      future: FavoritesService().getFatto(),
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
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CocktailDetailsPage(
                      cocktailId: cocktails[index].id,
                      onUpdate: () {
                        // Callback per ricaricare i dati
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                );
              },
              child: CocktailCard(cocktail: cocktails[index]),
            );
          },
        );
      },
    );
  }
}