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
          primarySwatch: Colors.purple,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        initialRoute: '/', // Atur halaman awal
        routes: {
          // '/': (context) => SplashScreen(), // Atur rute untuk splash screen
          // '/home': (context) => Homepage(), // Atur rute untuk home screen
          // '/detail': (context) => DetailRestaurant(), // Atur rute untuk detail screen
        },
      ),
    );
  }
}
