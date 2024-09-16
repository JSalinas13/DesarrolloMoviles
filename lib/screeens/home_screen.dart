import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:main_app/screeens/profile_screen.dart';
import 'package:main_app/settings/colors_settings.dart';
import 'package:main_app/settings/global_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.access_alarm_outlined),
          ),
          GestureDetector(
            onTap: () {},
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Image.asset('assets/game_logo.png'),
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 0:
              return Container(
                child: Text('Homa page'),
              );
            default:
              return ProfileScreen();
          }
        },
      ),
      endDrawer: Drawer(),
      // drawer: Drawer(),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        onTap: (int i) => setState(() {
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        children: [
          FloatingActionButton.small(
              onPressed: () {
                GlobalValues.banThemeDark.value = false;
              },
              child: Icon(Icons.light_mode)),
          FloatingActionButton.small(
              onPressed: () {
                GlobalValues.banThemeDark.value = true;
              },
              child: Icon(Icons.dark_mode)),
        ],
      ),
    );
  }
}