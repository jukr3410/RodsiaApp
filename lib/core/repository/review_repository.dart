import 'package:rodsiaapp/core/models/review_add_model.dart';
import 'package:rodsiaapp/core/repository/review_api.dart';

class ReviewRepository {
  final ReviewApi reviewApi = ReviewApi();

  static final ReviewRepository _reviewRepository = ReviewRepository._();

  ReviewRepository._();

  Future<bool> createReview({required ReviewAdd reviewAdd}) async {
    return await reviewApi.createReview(reviewAdd: reviewAdd);
  }
}
