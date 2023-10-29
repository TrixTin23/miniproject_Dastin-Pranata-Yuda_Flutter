import 'package:flutter/material.dart';
import 'package:hungryhub/restaurant_list/Model/restaurant_detail_model.dart';
import 'package:provider/provider.dart';

import '../../restaurant_list/Service/restaurant_manager.dart';
import '../service/review_provider.dart';

class ReviewView extends StatefulWidget {
  final String id;

  ReviewView({super.key, required this.id});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  late Future<RestaurantDetail> future;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = RestaurantService().getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Review"),
        ),
        body: FutureBuilder(
            future: future,
            builder: (BuildContext context,
                AsyncSnapshot<RestaurantDetail> snapshot) {
              if (snapshot.hasData) {
                final restaurant = snapshot.data!.restaurant;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.network(
                            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}"),
                        const SizedBox(height: 16),
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _reviewController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Review',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<ReviewProvider>(context, listen: false)
                                .addReview(
                                    widget.id,
                                    _nameController.text,
                                    _reviewController.text,
                                    DateTime.now().toString());
                            Navigator.pop(context);
                          },
                          child: const Text("Submit"),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
