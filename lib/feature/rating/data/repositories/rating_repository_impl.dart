import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/error/exceptions.dart';
import '../../../../core/utils/error/failure.dart';
import '../../domain/repositories/rating_repository.dart';
import '../dataSources/rating_remote_data_source.dart';


class RatingRepositoryImpl extends RatingRepository {
  final RatingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RatingRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> ratingPost(String serviceId, int rating) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.ratingPost(serviceId, rating);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }


}
