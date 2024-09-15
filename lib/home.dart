import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/beer_screen.dart';
import 'package:proyecto/drink.dart';
import 'package:proyecto/drinkCard.dart';
import 'package:toastification/toastification.dart';
import 'colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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

  void showNotification(String message, Color color) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      icon: const Icon(Icons.check),
      showIcon: true,
      primaryColor: color,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      variant: ToastificationType.minimal, // Estilo minimalista
    );
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
                'images/logo.png',
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
                  Drinkcard(getDrinks()[index], pageOffset, index),
            ),
          );
        },
      ),
    );
  }

  List<Drink> getDrinks() {
    return [
      Drink(
        'Tirami',
        'Sù',
        'images/blur_image.png',
        'images/bean_top.png',
        'images/bean_small.png',
        'images/bean_blur.png',
        'images/cup.png',
        'then top with whipped cream and mocha drizzle to bring you endless \njava joy',
        mBrownLight,
        mBrown,
      ),
      Drink(
        'Green',
        'Tea',
        'images/green_image.png',
        'images/green_top.png',
        'images/green_small.png',
        'images/green_blur.png',
        'images/green_tea_cup.png',
        'milk and ice and top it with sweetened whipped cream to give you \na delicious boost\nof energy.',
        greenLight,
        greenDark,
      ),
      Drink(
        'Triple',
        'Mocha',
        'images/mocha_image.png',
        'images/chocolate_top.png',
        'images/chocolate_small.png',
        'images/chocolate_blur.png',
        'images/mocha_cup.png',
        'layers of whipped cream that’s infused with cold brew, white chocolate mocha and dark \ncaramel.',
        mBrownLight,
        mBrown,
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
    return ToastificationWrapper(
      child: Scaffold(
        body: Builder(builder: (context) {
          switch (index) {
            case 0: // Starbucks
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    buildToolbar(),
                    buildLogo(size),
                    buildPager(size),
                    buildPageIndicator(),
                  ],
                ),
              );
            case 1: // Beers
              return BeerScreen();
            default:
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    buildToolbar(),
                    buildLogo(size),
                    buildPager(size),
                    buildPageIndicator(),
                  ],
                ),
              );
          }
        }),
        bottomNavigationBar: ConvexAppBar(
          color: Colors.white,
          backgroundColor: backColorBar,
          items: [
            TabItem(icon: Icons.coffee, title: 'Starbucks'),
            TabItem(icon: Icons.sports_bar, title: 'Cervezas'),
          ],
          onTap: (int i) => setState(() {
            index = i;
            backColorBar = (i == 0) ? mAppGreen : mainColor;
            String message =
                (i == 0) ? 'Cambiaste a Starbucks' : 'Cambiaste a Cervezas';
            showNotification(message, backColorBar);
          }),
        ),
      ),
    );
  }
}
