import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/network/response/details_response.dart';


abstract class BaseRepository {
  Future<List<Media>> getTopRatedMovies();

  Future<DetailsResponse> getMovieDetails(String id);

  Future<List<Media>> getNowPlaying();

  Future<List<Media>> getPopularMovies();

  Future<List<Media>> getTopRatedTv();

  Future<Media> getMediaDetails(MediaType type, String id);

  Future<List<MediaModels>> getTopRatedMedias();

  Future<List<Media>> getMediaByCategory(MediaCategory category);

}
