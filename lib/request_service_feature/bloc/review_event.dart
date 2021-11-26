part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class CreateReview extends ReviewEvent {
  final ReviewAdd reviewAdd;

  const CreateReview({required this.reviewAdd});

  @override
  String toString() => 'CreateReview {reviewAdd: $reviewAdd}';
}
