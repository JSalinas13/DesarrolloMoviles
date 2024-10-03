import 'package:flutter/material.dart';
import 'package:onboarding/settings/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeScreen extends StatefulWidget {
  const CustomThemeScreen({super.key});

  @override
  State<CustomThemeScreen> createState() => _CustomThemeScreenState();
}

class _CustomThemeScreenState extends State<CustomThemeScreen> {
  // Inicializar colores y fuentes por defecto
  Color? _primaryColor = const Color.fromARGB(255, 255, 255, 255); // Valor predeterminado
  Color? _accentColor = const Color.fromARGB(255, 0, 0, 0); // Valor predeterminado
  String? _selectedFont = 'Roboto'; // Fuente predeterminada

  late SharedPreferences _prefs;

  final List<Color> colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
  ];

  final List<String> fontOptions = [
    'Roboto',
    'Lobster',
    'Oswald',
    'Pacifico',
  ];
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance(); // Asigna _prefs
  }

  Future<void> _savePreferences() async {
    await _prefs.setBool('banThemeCustom', true);
    await _prefs.setBool('banThemeDark', false);

    // Asegurarse de que los colores y la fuente no sean nulos
    if (_primaryColor != null &&
        _accentColor != null &&
        _selectedFont != null) {
      await _prefs.setInt('primaryColor', _primaryColor!.value);
      await _prefs.setInt('accentColor', _accentColor!.value);
      await _prefs.setString('selectedFont', _selectedFont!);

      GlobalValues.primaryColor.value = _primaryColor;
      GlobalValues.accentColor.value = _accentColor;
      GlobalValues.selectedFont.value = _selectedFont;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaliza tu tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selecciona el color principal:',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: colorOptions.map((Color color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _primaryColor = color;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 30,
                    child: _primaryColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Selecciona el color del navbar:',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: colorOptions.map((Color color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _accentColor = color;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 30,
                    child: _accentColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Selecciona la fuente:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedFont,
              items: fontOptions.map((String font) {
                return DropdownMenuItem<String>(
                  value: font,
                  child: Text(font, style: TextStyle(fontFamily: font)),
                );
              }).toList(),
              onChanged: (String? newFont) {
                setState(() {
                  _selectedFont = newFont!;
                });
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _savePreferences(); // Guarda las preferencias
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preferencias guardadas'),
                    ),
                  );

                  GlobalValues.banThemeCustom.value =
                      true; // Actualiza el valor global
                  GlobalValues.banThemeDark.value = !GlobalValues
                      .banThemeDark.value; // Desactiva el tema oscuro

                  Navigator.pushNamed(
                      context, '/home'); // Navega a la pantalla de inicio
                },
                child: const Text('Aplicar tema'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
