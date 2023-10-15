import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hungryhub/Model/restaurant_model.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  final Dio _dio = Dio();

  Future<void> fetchRestaurants() async {
    try {
      final response =
          await _dio.get('https://restaurant-api.dicoding.dev/list');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> restaurantData = data['restaurants'];

        List<Restaurant> loadedRestaurants = [];
        for (var restaurant in restaurantData) {
          loadedRestaurants.add(
            Restaurant(
              id: restaurant['id'],
              name: restaurant['name'],
              city: restaurant['city'],
              description: restaurant['description'],
              pictureId: restaurant['pictureId'],
              rating: restaurant['rating'],
            ),
          );
        }

        _restaurants = loadedRestaurants;
        notifyListeners();
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      throw Exception('Failed to load data from the API: $error');
    }
  }
}
