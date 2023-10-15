import 'package:flutter/material.dart';
import 'package:hungryhub/Model/provider/restaurant_manager.dart';
import 'package:hungryhub/Model/restaurant_model.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantRepository _repository = RestaurantRepository();
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  Future<void> fetchRestaurants() async {
    try {
      _restaurants = await _repository.fetchRestaurants();
      notifyListeners();
    } catch (e) {
      throw Exception("error: $e");
    }
  }
}
