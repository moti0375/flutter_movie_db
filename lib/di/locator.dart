import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:flutter_movie_db/network/retrofit_base_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final locator = GetIt.instance;

Future setupLocator() async {

  locator.registerLazySingleton<BaseRetrofitClient>((){
    Dio dio = Dio();
    return BaseRetrofitClient(dio);
  });

  locator.registerLazySingleton<Repository>(() => TmdbRepository(client: locator.get<BaseRetrofitClient>()));

}