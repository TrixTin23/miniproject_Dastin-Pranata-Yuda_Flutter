import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Service/restaurant_provider.dart';
import 'detail_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantListViewModel>(context, listen: false)
        .fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hungry Hub'),
      ),
      body: Consumer<RestaurantListViewModel>(
        builder: (context, model, child) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (model.message.isNotEmpty) {
            return Center(child: Text(model.message));
          } else {
            return ListView.builder(
              itemCount: model.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = model.restaurants[index];
                return Card(
                  elevation: 3, // Menambah elevasi untuk card
                  margin: const EdgeInsets.all(8), // Menambah margin pada card
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        fit: BoxFit.cover,
                        height: 150, // Mengatur tinggi gambar
                      ),
                      ListTile(
                        title: Text(
                          restaurant.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          restaurant.city,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              restaurant.rating.toString(),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            RatingBarIndicator(
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              },
                              rating: restaurant.rating,
                              itemCount: 5,
                              itemSize: 15,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RestaurantDetailPage(id: restaurant.id))),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
