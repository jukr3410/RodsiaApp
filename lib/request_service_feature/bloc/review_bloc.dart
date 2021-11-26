import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/review_add_model.dart';
import 'package:rodsiaapp/core/repository/review_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;
  ReviewBloc({required this.reviewRepository}) : super(ReviewInitial()) {}

  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async* {
    if (event is CreateReview) {
      yield* _createReviewToState(event.reviewAdd);
    }
  }

  Stream<ReviewState> _createReviewToState(ReviewAdd review) async* {
    try {
      logger.d(review);
      await this.reviewRepository.createReview(reviewAdd: review);
      yield CreatedReview();
    } catch (e) {
      logger.e(e);
      yield ReviewError();
    }
  }
}
