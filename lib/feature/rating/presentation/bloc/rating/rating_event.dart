part of 'rating_bloc.dart';

// Abstract base class for all feed events
abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object> get props => [];
}

class RatingEventButton extends RatingEvent {
  final String serviceId;
  final int rating;

  const RatingEventButton({
    required this.serviceId,
    required this.rating,
  });

  @override
  List<Object> get props => [serviceId, rating];
}
