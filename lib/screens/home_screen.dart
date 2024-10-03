import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:onboarding/screens/profile_screen.dart';
import 'package:onboarding/settings/colors_settings.dart';
import 'package:onboarding/settings/global_values.dart';

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
            onPressed: () {
              Navigator.pushNamed(context, '/login');
              GlobalValues.banThemeCustom.value = false;
              GlobalValues.banThemeDark.value = false;
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 0:
              return Container(
                child: const Center(
                  child: Text('Home page '),
                ),
              );
            default:
              return const ProfileScreen();
          }
        },
      ),
      drawer: myDrawer(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        children: [
          FloatingActionButton.small(
              heroTag: "btn1",
              onPressed: () {
                GlobalValues.banThemeDark.value = false;
                GlobalValues.banThemeCustom.value = false;
              },
              child: const Icon(Icons.light_mode)),
          FloatingActionButton.small(
              heroTag: "btn2",
              onPressed: () {
                GlobalValues.banThemeDark.value = true;
                GlobalValues.banThemeCustom.value = false;
              },
              child: const Icon(Icons.dark_mode)),
          FloatingActionButton.small(
              heroTag: "btn3",
              onPressed: () {
                Navigator.pushNamed(context, '/customTheme');
              },
              child: const Icon(Icons.edit)),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            accountName: Text('Jesus Salinas'),
            accountEmail: Text('20030389@itcelaya.edu.mx'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/customTheme'),
            title: Text('Custom themes'),
            subtitle: Text('Tema personalizado'),
            leading: Icon(Icons.edit),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
