part of 'rating_bloc.dart';

// exemple of list services
class Item {
  final String id;
  final String text;
  int? ratingGivenByMe;

  Item({required this.id, required this.text, this.ratingGivenByMe});
}

class RatingState extends Equatable {
  final bool isLoading;
  final String error;
  final List<Item> allServices;

  const RatingState({
    this.isLoading = false,
    this.error = "",
    this.allServices = const [],
  });

  RatingState copyWith({
    bool? isLoading,
    String? error,
    List<Item>? allServices,
  }) {
    return RatingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      allServices: allServices ?? this.allServices,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, allServices];
}
