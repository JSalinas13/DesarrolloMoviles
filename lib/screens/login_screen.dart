import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.person,
        ),
      ),
      controller: conUser,
    );

    TextFormField txtPwd = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.password,
        ),
      ),
      obscureText: true,
    );

    final ctnCredentials = Container(
      width: screenSize.width * .9,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [txtUser, txtPwd],
      ),
    );

    final btnLogin = SizedBox(
      width: screenSize.width * .5,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 178, 202),
        ),
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          Future.delayed(
            const Duration(milliseconds: 4000),
          ).then((response) => {
                setState(() {
                  isLoading = false;
                }),
                Navigator.pushNamed(context, "/onboarding")
              });
        },
        child: const Text('Iniciar Sesión'),
      ),
    );

    final gifLoading = Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: const BoxDecoration(
        color: Color.fromARGB(141, 0, 0, 0),
      ),
      child: Image.asset('assets/loading.gif'),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/back2.webp"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenSize.height,
                minWidth: screenSize.width,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: isLandscape
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (!isLandscape)
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          'assets/logo.png',
                          width: screenSize.width *
                              0.6, // Ajusta el ancho del logo
                        ),
                      ),
                    const SizedBox(height: 30),
                    // Credenciales
                    ctnCredentials,
                    const SizedBox(height: 20),
                    // Botón de login
                    btnLogin,
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) gifLoading,
        ],
      ),
    );
  }
}
