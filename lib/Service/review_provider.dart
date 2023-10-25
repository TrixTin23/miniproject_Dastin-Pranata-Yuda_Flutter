import 'package:flutter/foundation.dart';

import '../Model/restaurant_review_model.dart';
import 'review_service.dart';

class ReviewProvider extends ChangeNotifier {
  final ReviewService _service = ReviewService();
  List<Review> _customerReviews = [];

  List<Review> get customerReviews => _customerReviews;

  void addReview(String id, String name, String review, String date) async {
    try {
      final result = await _service.createReview(id, name, review, date);
      _customerReviews = result;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
