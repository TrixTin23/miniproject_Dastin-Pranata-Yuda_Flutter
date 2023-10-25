// services/restaurant_service.dart
import 'package:dio/dio.dart';

import '../Model/restaurant_detail_model.dart';
import '../Model/restaurant_model.dart';

class RestaurantService {
  static const String _baseUrl =
      "https://restaurant-api.dicoding.dev";

  Future<RestaurantList> getList() async {
    final response = await Dio().get(_baseUrl + "/list");
    return RestaurantList.fromJson(response.data);
  }

  Future<RestaurantDetail> getDetail(String id) async {
    final response = await Dio().get(_baseUrl + "/detail/$id");
    return RestaurantDetail.fromJson(response.data);
  }
}
