import 'dart:convert';
import 'package:dio/dio.dart';

import '../model/restaurant_review_model.dart';


class ReviewService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<List<Review>> createReview(String id, String name, String review, String date) async {
    try {
      final response = await _dio.post(
        _baseUrl + "review",
        data: jsonEncode(Review(id: id, name: name, review: review, date: date).toJson()),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      final data = response.data['customerReviews'] as List;
      return data.map((e) => Review.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
