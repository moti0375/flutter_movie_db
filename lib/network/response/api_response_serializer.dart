import 'package:flutter_movie_db/data/model/genre.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/network/response/details_response.dart';
import 'package:flutter_movie_db/network/response/api_response.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'api_response_serializer.jser.dart';

@GenSerializer()
class ApiResponseJsonSerializer extends Serializer<ApiResponse> with _$ApiResponseJsonSerializer {
  @override
  ApiResponse fromMap(Map map) {
    ApiResponse response = ApiResponse.fromJson(map);
    print("fromMap: map: ${response.toString()}");
    return response;
  }

  @override
  Map<String, dynamic> toMap(ApiResponse model) {
    return {};
  }
}

@GenSerializer()
class GenereJsonSerializer extends Serializer<Genre> with _$GenereJsonSerializer {
  @override
  fromMap(Map map) {
    return Genre.fromJson(map);
  }

  @override
  Map<String, dynamic> toMap(model) {
    return null;
  }
}

@GenSerializer()
class MovieJsonSerializer extends Serializer<Movie> with _$MovieJsonSerializer {
  @override
  fromMap(Map map) {
    return Movie.fromJson(map);
  }

  @override
  Map<String, dynamic> toMap(model) {
    return null;
  }
}

@GenSerializer()
class MovieDetailsJsonSerializer extends Serializer<DetailsResponse> with _$MovieDetailsJsonSerializer {
  @override
  fromMap(Map map) {
    return DetailsResponse.fromJson(map);
  }

  @override
  Map<String, dynamic> toMap(model) {
    return null;
  }

}