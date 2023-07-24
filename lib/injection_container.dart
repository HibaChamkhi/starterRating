import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'feature/rating/data/dataSources/rating_remote_data_source.dart';
import 'feature/rating/data/repositories/rating_repository_impl.dart';
import 'feature/rating/domain/repositories/rating_repository.dart';
import 'feature/rating/domain/usecases/rating_use_case.dart';
import 'feature/rating/presentation/bloc/rating/rating_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => RatingBloc( ratingUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => RatingUseCase( repository: sl()));

  // Repository
  sl.registerLazySingleton<RatingRepository>(
      () => RatingRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), ));

  // DataSources
  sl.registerLazySingleton<RatingRemoteDataSource>(
      () => RatingRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


//
}
