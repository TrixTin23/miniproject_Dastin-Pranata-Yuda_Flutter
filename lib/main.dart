import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login_Register/Service/auth_view_model.dart';
import 'restaurant_list/Service/restaurant_provider.dart';
import 'review_form/service/review_provider.dart';
import 'widget/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RestaurantListViewModel()),
        ChangeNotifierProvider(create: (context) => ReviewProvider()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HungryHub',
        theme: ThemeData(
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xff606c5d),
              onPrimary: Color(0xfff1c376),
              secondary: Color(0xfff1c376),
              onSecondary: Color(0xff606c5d),
              error: Colors.red,
              onError: Colors.white,
              background: Color(0xfffff4f4),
              onBackground: Color(0xff606c5d),
              surface: Colors.white,
              onSurface: Colors.black),
          scaffoldBackgroundColor: const Color(0xfffff4f4),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff606c5d),
            titleTextStyle: TextStyle(
                color: Color(0xfff1c376),
                fontWeight: FontWeight.bold,
                fontSize: 20),
            iconTheme: IconThemeData(color: Color(0xfff1c376)),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
