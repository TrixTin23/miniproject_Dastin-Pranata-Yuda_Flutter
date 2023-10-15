import 'package:flutter/material.dart';
import 'package:hungryhub/Model/provider/restaurant_provider.dart';
import 'package:hungryhub/View/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RestaurantProvider()),
      ],
      child: MaterialApp(
        title: 'HungryHub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
