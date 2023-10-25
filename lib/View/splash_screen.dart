import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:hungryhub/View/restaurant_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: Duration(seconds: 3),
      backgroundColor: const Color(0xff272829),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      onAnimationEnd: () => debugPrint("NextScreen"),
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/images/Hungry-hub.png"),
      ),
      nextScreen: const RestaurantListPage(),
    );
  }
}
