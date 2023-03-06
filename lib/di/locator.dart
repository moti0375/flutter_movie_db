import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:flutter_movie_db/network/api_key_dio_interceptor.dart';
import 'package:flutter_movie_db/network/retrofit_base_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final locator = GetIt.instance;

Future setupLocator() async {

  locator.registerLazySingleton<Dio>((){
    Dio dio = Dio();
    dio.interceptors.add(ApiKeyInterceptor(API_KEY));
    return dio;
  });

  locator.registerLazySingleton<BaseRetrofitClient>((){
    return BaseRetrofitClient(locator.get<Dio>());
  });

  locator.registerLazySingleton<Repository>(() => TmdbRepository(locator.get<BaseRetrofitClient>()));

}