import 'package:dartz/dartz.dart';

import '../../../../../core/utils/error/failure.dart';
import '../repositories/rating_repository.dart';


class RatingUseCase {
  final RatingRepository repository;

  RatingUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String serviceId, int rating) async {
    return await repository.ratingPost( serviceId, rating);
  }
}