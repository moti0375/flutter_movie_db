import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_base_service.g.dart';


@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class BaseRetrofitClient {
  factory BaseRetrofitClient(Dio dio, {String baseUrl}) = _BaseRetrofitClient;

  @GET("movie/top_rated")
  Future<dynamic> getTopRatedMovies();


  @GET("movie/now_playing")
  Future<dynamic> getNowPlaying();

  // @GET("movie/:id")
  // Future<DetailsResponse> getMovieDetails(String id);
  @GET("movie/popular")
  Future<dynamic> getPopularMovies();

  @GET("tv/top_rated")
  Future<dynamic> getTopRatedTv();

  @GET("{type}/{id}")
  Future<dynamic> getMediaDetails(@Path("type") String type, @Path("id") String id);
  //
  // Future<List<MediaModels>> getTopRatedMedias();
  //
  // Future<List<Media>> getMediaByCategory(MediaCategory category);

}