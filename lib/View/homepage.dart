import 'package:flutter/material.dart';
import 'package:hungryhub/View/restaurant_card.dart';
import 'package:provider/provider.dart';

import '../Model/provider/restaurant_provider.dart';
import '../Model/restaurant_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final List<Restaurant> restaurants = restaurantProvider.restaurants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hungry Hub'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantCard(restaurants[index]);
        },
      ),
    );
  }
}
