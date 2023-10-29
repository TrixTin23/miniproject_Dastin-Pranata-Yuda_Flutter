import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:hungryhub/Login_Register/View/login_page.dart';
// import 'package:hungryhub/View/restaurant_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 3),
      backgroundColor: const Color(0xffFFF4F4),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      onAnimationEnd: () => debugPrint("NextScreen"),
      childWidget: SizedBox(
        height: 500,
        width: 500,
        child: Image.asset("assets/images/Hungry-hub.png"),
      ),
      nextScreen: LoginScreen(),
    );
  }
}
