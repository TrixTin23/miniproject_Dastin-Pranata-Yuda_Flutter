import 'package:flutter/foundation.dart';

import 'restaurant_manager.dart';
import '../Model/restaurant_model.dart';

class RestaurantListViewModel extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;
  String get message => _message;

  final RestaurantService _restaurantManager = RestaurantService(); // Pastikan Anda mengganti ini sesuai dengan nama service yang sesuai

  Future<void> fetchRestaurants() async {
    try {
      Future.delayed(Duration.zero, () {
        _isLoading = true;
        notifyListeners();
      });
      final results = await _restaurantManager.getList();
      if (results.error) {
        _message = results.message;
      } else {
        _restaurants = results.restaurants;
      }
    } catch (e) {
      _message = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
