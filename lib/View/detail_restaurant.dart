import 'package:flutter/material.dart';
import 'package:hungryhub/Model/restaurant_model.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  DetailRestaurant(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(restaurant.description),
                  SizedBox(height: 16),
                  Text(
                    'City: ${restaurant.city}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Rating: ${restaurant.rating.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
