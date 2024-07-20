import 'package:flutter/material.dart';
import 'favourite_tabs/created_tab.dart';
import 'favourite_tabs/favorite_tab.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: TabBar(
            tabs: [
              Tab(text: 'Preferiti',icon: Icon(Icons.favorite),),
              Tab(text: 'Creati da me',icon: Icon(Icons.account_circle),),
            ],
          ),
        body: TabBarView(
          children: [
            PreferitiTab(),
            CreatiDaMeTab(),
          ],
        ),
      ),
    );
  }
}
