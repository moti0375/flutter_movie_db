import 'package:flutter_movie_db/data/model/genre.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/network/response/details_response.dart';
import 'package:flutter_movie_db/network/response/api_response.dart';

// part 'api_response_serializer.jser.dart';

// @GenSerializer()
class ApiResponseJsonSerializer  {
  ApiResponse fromMap(Map<String, dynamic> map) {
    ApiResponse response = ApiResponse.fromJson(map);
    print("fromMap: map: ${response.toString()}");
    return response;
  }

  Map<String, dynamic> toMap(ApiResponse model) {
    return {};
  }
}

// @GenSerializer()
class GenereJsonSerializer  {
  fromMap(Map<String, dynamic> map) {
    return Genre.fromJson(map);
  }

  Map<String, dynamic> toMap(model) {
    return {};
  }
}

class MovieJsonSerializer  {
  fromMap(Map<String, dynamic> map) {
    return Movie.fromJson(map);
  }

  Map<String, dynamic> toMap(model) {
    return {};
  }
}

class MovieDetailsJsonSerializer  {
  fromMap(Map<String, dynamic> map) {
    return DetailsResponse.fromJson(map);
  }

  Map<String, dynamic> toMap(model) {
    return {};
  }

}