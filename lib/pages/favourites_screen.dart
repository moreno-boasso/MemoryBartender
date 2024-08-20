import 'package:flutter/material.dart';
import '../styles/colors.dart';
import 'favourite_tabs/created_tab.dart';
import 'favourite_tabs/favorite_tabs.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Da Provare', icon: Icon(Icons.access_time_filled)),
                Tab(text: 'Fatto', icon: Icon(Icons.check_circle)),
                Tab(text: 'Creati da me', icon: Icon(Icons.account_circle)),
              ],
              indicatorColor: MemoColors.brownie,
              labelColor: MemoColors.brownie,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  DaProvareTab(),
                  FattoTab(),
                  CreatiDaMeTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
