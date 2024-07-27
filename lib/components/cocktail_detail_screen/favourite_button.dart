import 'package:flutter/material.dart';
import '../../models/cocktail.dart';
import '../../services/favorite_service.dart';
import '../../styles/colors.dart';

class FavoriteButton extends StatefulWidget {
  final Cocktail cocktail;

  const FavoriteButton({super.key, required this.cocktail});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isInDaProvare = false;
  bool isInFatto = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    isInDaProvare = await FavoritesService().isCocktailInDaProvare(widget.cocktail.id);
    isInFatto = await FavoritesService().isCocktailInFatto(widget.cocktail.id);
    setState(() {});
  }

  Future<void> _updateFavorites(String category) async {
    // Remove from both categories first
    await FavoritesService().removeFromDaProvare(widget.cocktail.id);
    await FavoritesService().removeFromFatto(widget.cocktail.id);

    if (category == 'Da Provare') {
      await FavoritesService().addToDaProvare(widget.cocktail);
    } else if (category == 'Fatto') {
      await FavoritesService().addToFatto(widget.cocktail);
    }

    await _checkIfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;

    if (isInFatto) {
      icon = Icons.check;
      iconColor = Colors.green;
    } else if (isInDaProvare) {
      icon = Icons.access_time;
      iconColor = Colors.blue;
    } else {
      icon = Icons.favorite_border;
      iconColor = MemoColors.black;
    }

    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 26,
      right: 25,
      child: Stack(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MemoColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value != (isInDaProvare ? 'Da Provare' : isInFatto ? 'Fatto' : '')) {
                    await _updateFavorites(value);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Da Provare',
                    child: Text('Da Provare'),
                  ),
                  const PopupMenuItem(
                    value: 'Fatto',
                    child: Text('Fatto'),
                  ),
                ],
                icon: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
