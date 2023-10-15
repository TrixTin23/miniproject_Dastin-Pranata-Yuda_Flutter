import 'package:flutter/material.dart';
import 'package:hungryhub/Model/provider/restaurant_provider.dart';
import 'package:hungryhub/View/homepage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);

    // Fetch data when the splash screen is loaded
    restaurantProvider.fetchRestaurants();

    // Delay for 2 seconds and then navigate to the home screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);

    // Fetch data when the splash screen is loaded
    restaurantProvider.fetchRestaurants();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Center(
        child: Image.asset(
          'assets/images/logo1.jpg',
          width: 200,
        ),
      ),
    );
  }
}
