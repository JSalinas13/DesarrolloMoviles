import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:onboarding/screens/custom_theme_screen.dart';
import 'package:onboarding/screens/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Terminar',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: kDarkBlueColor,
      ),
      skipTextButton: Text(
        'Saltar',
        style: TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      controllerColor: kDarkBlueColor,
      totalPage: 5,
      headerBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      pageBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      background: [
        Lottie.asset(
          'assets/welcome.json', // Reemplaza por tu animación de carga
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.contain,
        ),
        Image.asset(
          'assets/home.png',
          height: MediaQuery.of(context).size.height * .50,
          width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          'assets/pencil.png',
          height: MediaQuery.of(context).size.height * .50,
          width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          'assets/slide_2.png',
          height: MediaQuery.of(context).size.height * .50,
          width: MediaQuery.of(context).size.width,
        ),
        Lottie.asset(
          'assets/menu_drawer.json', // Reemplaza por tu animación de carga
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.contain,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Bienvenid@!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'En esta aplicación podras cambiar el tema de la app a tu gusto, o seleccionar tema claro u oscuro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 198, 198, 198),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Tema y fuente.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkBlueColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Para poder seleccionar un tema personalizado tienes que dar clic en el boton inferior derecho',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Tema y fuente.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkBlueColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Después dar clic en el boton con el lapiz ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        CustomThemeScreen(), 
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Menú lateral',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkBlueColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Para acceder a menú lateral debes dar clic en el boton superior izquierdo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 213, 213, 213),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
