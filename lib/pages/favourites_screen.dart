import 'package:flutter/material.dart';
import 'package:memory_bartender/pages/favourite_tabs/fato_tab.dart';
import 'favourite_tabs/created_tab.dart';
import 'favourite_tabs/da_provare_tab.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
            tabs: [
              Tab(text: 'Da Provare',icon: Icon(Icons.favorite),),
              Tab(text: 'Fatto',icon: Icon(Icons.favorite),),
              Tab(text: 'Creati da me',icon: Icon(Icons.account_circle),),
            ],
          ),
        body: TabBarView(
          children: [
            DaProvareTab(),
            FattoTab(),
            CreatiDaMeTab(),
          ],
        ),
      ),
    );
  }
}
