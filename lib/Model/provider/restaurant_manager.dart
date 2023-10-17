import 'package:dio/dio.dart';
import 'package:hungryhub/Model/restaurant_model.dart';

class RestaurantRepository {
  final Dio _dio = Dio();

  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await _dio.get("https://restaurant-api.dicoding.dev/list");
      // final response = await _dio.get("https://652ce537d0d1df5273efd2ec.mockapi.io/list");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['restaurants'];
        List<Restaurant> restaurants = data.map((json) => Restaurant.fromJson(json)).toList();
        return restaurants;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw e;
    }
  }
}