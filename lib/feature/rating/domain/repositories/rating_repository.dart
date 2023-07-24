import 'package:dartz/dartz.dart';

import '../../../../core/utils/error/failure.dart';

abstract class RatingRepository {
  Future<Either<Failure, Unit>> ratingPost(String serviceId, int rating);

}
