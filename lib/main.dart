import 'package:flutter/material.dart';
import 'package:onboarding/screens/custom_theme_screen.dart';
import 'package:onboarding/screens/home_screen.dart';
import 'package:onboarding/screens/login_screen.dart';
import 'package:onboarding/screens/oboarding_screen.dart';
import 'package:onboarding/settings/global_values.dart';
import 'package:onboarding/settings/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      final banThemeCustom = _prefs.getBool('banThemeCustom') ?? false;
      final banThemeDark = _prefs.getBool('banThemeDark') ?? false;

      if (!banThemeDark && banThemeCustom) {
        GlobalValues.banThemeCustom.value = true;
        GlobalValues.banThemeDark.value = !GlobalValues.banThemeDark.value;

        GlobalValues.primaryColor.value = _prefs.getInt('primaryColor');
        GlobalValues.accentColor.value = _prefs.getInt('accentColor');
        GlobalValues.selectedFont.value = _prefs.getString('selectedFont');
      } else {
        GlobalValues.banThemeDark.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banThemeDark,
        builder: (context, value, widget) {
          return MaterialApp(
            theme: value && !GlobalValues.banThemeCustom.value
                ? ThemeSettings.darkTheme()
                : GlobalValues.banThemeCustom.value
                    ? ThemeSettings.customTheme(
                        Color(_prefs.getInt('primaryColor')!),
                        Color(_prefs.getInt('accentColor')!),
                        _prefs.getString('selectedFont')!)
                    : ThemeSettings.warmTheme(),
            // theme: value ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            title: 'Onboarding app',
            home: const LoginScreen(),
            routes: {
              "/home": (context) => const HomeScreen(),
              "/customTheme": (context) => const CustomThemeScreen(),
              "/onboarding": (context) => const OnboardingScreen(),
              "/login": (context) => const LoginScreen(),
              // "/db": (context) => const MoviesScreen()
            },
          );
        });
  }
}
