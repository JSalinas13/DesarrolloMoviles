import 'package:flutter/material.dart';
import 'package:main_app/screeens/detaill_popular_screen.dart';
import 'package:main_app/screeens/home_screen.dart';
import 'package:main_app/screeens/login_screen.dart';
import 'package:main_app/screeens/movies_screen.dart';
import 'package:main_app/screeens/popular_screen.dart';
import 'package:main_app/settings/global_values.dart';
import 'package:main_app/settings/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banThemeDark,
        builder: (context, value, widget) {
          return MaterialApp(
            theme:
                value ? ThemeSettings.darkTheme() : ThemeSettings.ligthTheme(),
            // theme: value ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            title: 'Metrial App',
            home: const LoginScreen(),
            routes: {
              "/home": (context) => const HomeScreen(),
              "/db": (context) => const MoviesScreen(),
              "/popularMovies": (context) => const PopularScreen(),
              "/detaill": (context) => const DetaillPopularScreen()
            },
          );
        });
  }
}
