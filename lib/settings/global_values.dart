import 'package:flutter/material.dart';

class GlobalValues {
  static ValueNotifier banThemeDark = ValueNotifier(false);
  static ValueNotifier banThemeCustom = ValueNotifier(false);
  static ValueNotifier banUpdListMoviews = ValueNotifier(false);

  static ValueNotifier primaryColor =
      ValueNotifier(Color.fromARGB(255, 255, 255, 255));
  static ValueNotifier accentColor =
      ValueNotifier(Color.fromARGB(255, 255, 255, 255));
  static ValueNotifier selectedFont = ValueNotifier('Roboto');
}
