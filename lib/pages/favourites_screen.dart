import 'package:flutter/material.dart';
import 'favourite_tabs/created_tab.dart';
import 'favourite_tabs/da_provare_tab.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferiti'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Da Provare', icon: Icon(Icons.access_time)),
            Tab(text: 'Fatto', icon: Icon(Icons.check)),
            Tab(text: 'Creati da me', icon: Icon(Icons.account_circle)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DaProvareTab(), // Assicurati che questo widget sia definito correttamente
          FattoTab(),     // Assicurati che questo widget sia definito correttamente
          CreatiDaMeTab(), // Assicurati che questo widget sia definito correttamente
        ],
      ),
    );
  }
}
