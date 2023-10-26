import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hungryhub/Model/restaurant_detail_model.dart';

import '../Service/restaurant_manager.dart';
import 'review_form.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String id;
  RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<RestaurantDetail> future;

  @override
  void initState() {
    super.initState();
    future = RestaurantService().getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewView(id: widget.id),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<RestaurantDetail>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<RestaurantDetail> snapshot) {
          if (snapshot.hasData) {
            final restaurant = snapshot.data!.restaurant;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(restaurant.city),
                            const Spacer(),
                            RatingBarIndicator(
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              rating: restaurant.rating,
                              itemCount: 5,
                              itemSize: 16.0,
                              direction: Axis.horizontal,
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurant.address,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          restaurant.description,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: restaurant.categories
                              .map((category) => Chip(
                                    label: Text(category.name),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Menus',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Foods'),
                                ...restaurant.menus.foods
                                    .map((food) => Text('- ${food.name}'))
                                    .toList(),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Drinks'),
                                ...restaurant.menus.drinks
                                    .map((drink) => Text('- ${drink.name}'))
                                    .toList(),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Customer Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurant.customerReviews.length,
                          itemBuilder: (context, index) {
                            final review = restaurant.customerReviews[index];
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title: Text(review.name),
                                subtitle: Text(review.review),
                                trailing: Text(review.date),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
