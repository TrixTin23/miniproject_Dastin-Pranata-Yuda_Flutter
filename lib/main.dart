import 'package:flutter/material.dart';
import 'package:hungryhub/Service/restaurant_provider.dart';
import 'package:hungryhub/View/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantListViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HungryHub',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xfff1efef),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff272829),
            titleTextStyle: TextStyle(
                color: Color(0xffd2e603),
                fontWeight: FontWeight.bold,
                fontSize: 20),
            iconTheme: IconThemeData(color: Color(0xffd2e603)),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
