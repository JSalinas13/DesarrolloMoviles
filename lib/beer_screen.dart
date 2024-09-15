import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/drink.dart';
import 'package:proyecto/beerCard.dart';
import 'colors.dart';

class BeerScreen extends StatefulWidget {
  @override
  _BeerScreenState createState() => _BeerScreenState();
}

class _BeerScreenState extends State<BeerScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  int index = 0;
  late PageController pageController;
  double pageOffset = 0;
  late Color backColorBar;

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page ?? 0;
      });
    });
    backColorBar = mAppGreen;
  }

  Widget buildToolbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-200 * (1 - animation.value), 0),
                child: Image.asset(
                  'images/location.png',
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          Spacer(),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(200 * (1 - animation.value), 0),
                child: Image.asset(
                  'images/drawer.png',
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, size.height / 2 * (1 - animation.value))
              ..scale(1 + (1 - animation.value)),
            origin: Offset(25, 25),
            child: InkWell(
              onTap: () => controller.isCompleted
                  ? controller.reverse()
                  : controller.forward(),
              child: Image.asset(
                'images/beer_logo.png',
                width: 50,
                height: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(400 * (1 - animation.value), 0),
            child: PageView.builder(
              controller: pageController,
              itemCount: getDrinks().length,
              itemBuilder: (context, index) =>
                  BeerCard(getDrinks()[index], pageOffset, index),
            ),
          );
        },
      ),
    );
  }

  List<Drink> getDrinks() {
    return [
      Drink(
        'Modelo',
        'Negra',
        'images/modelo_blur.webp',
        'images/agua.png',
        'images/hielo.png',
        'images/hielos_top.png',
        'images/negra.png',
        'Elaborada con una cuidadosa selección de maltas oscuras y café de calidad, \nesta cerveza ofrece una experiencia de degustación única para aquellos que \naprecian la combinación de sabores tostados y amargos. ',
        mBlackLight,
        mBlack,
      ),
      Drink(
        'Modelo',
        'Noche',
        'images/modelo_blur.webp',
        'images/agua.png',
        'images/hielo.png',
        'images/hielo.png',
        'images/roja.png',
        'Esta edición especial está diseñada para ofrecer una experiencia de degustación más intensa y robusta, \ncon un perfil de sabor más complejo y una mayor concentración de maltas tostadas. ',
        mRedLight,
        mRed,
      ),
      Drink(
        'Modelo',
        'Especial',
        'images/modelo_blur.webp',
        'images/agua.png',
        'images/hielo.png',
        'images/hielo.png',
        'images/especial.png',
        'Es una de las cervezas más populares y reconocidas en el país, \nconocida por su sabor equilibrado y refrescante. ',
        mAmarilloLight,
        mAmarillo,
      ),
    ];
  }

  Widget buildPageIndicator() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller.value,
            child: Row(
              children: List.generate(
                  getDrinks().length, (index) => buildContainer(index)),
            ),
          ),
        );
      },
    );
  }

  Widget buildContainer(int index) {
    double animate = (pageOffset - index).abs();
    double size = 10 + (1 - animate).clamp(0, 1) * 10;
    Color color = ColorTween(begin: Colors.grey, end: mAppGreen)
        .transform((1 - animate).clamp(0, 1))!;

    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolbar(),
            buildLogo(size),
            buildPager(size),
            buildPageIndicator(),
          ],
        ),
      ),
    );
  }
}
