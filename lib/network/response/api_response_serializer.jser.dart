// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_serializer.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ApiResponseJsonSerializer implements Serializer<ApiResponse> {
  Serializer<Movie> __movieJsonSerializer;
  Serializer<Movie> get _movieJsonSerializer =>
      __movieJsonSerializer ??= MovieJsonSerializer();
  @override
  Map<String, dynamic> toMap(ApiResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'page', model.page);
    setMapValue(ret, 'total_results', model.total_results);
    setMapValue(ret, 'total_pages', model.total_pages);
    setMapValue(
        ret,
        'results',
        codeIterable(
            model.results, (val) => _movieJsonSerializer.toMap(val as Movie)));
    return ret;
  }

  @override
  ApiResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = ApiResponse();
    obj.page = map['page'] as int;
    obj.total_results = map['total_results'] as int;
    obj.total_pages = map['total_pages'] as int;
    obj.results = codeIterable<Movie>(map['results'] as Iterable,
        (val) => _movieJsonSerializer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$GenereJsonSerializer implements Serializer<Genre> {
  @override
  Map<String, dynamic> toMap(Genre model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'props',
        codeIterable(model.props, (val) => passProcessor.serialize(val)));
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'stringify', model.stringify);
    return ret;
  }

  @override
  Genre fromMap(Map map) {
    if (map == null) return null;
    final obj = Genre(
        id: map['id'] as int ?? getJserDefault('id'),
        name: map['name'] as String ?? getJserDefault('name'));
    return obj;
  }
}

abstract class _$MovieJsonSerializer implements Serializer<Movie> {
  Serializer<Genre> __genereJsonSerializer;
  Serializer<Genre> get _genereJsonSerializer =>
      __genereJsonSerializer ??= GenereJsonSerializer();
  @override
  Map<String, dynamic> toMap(Movie model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'vote_count', model.vote_count);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'vote_average', model.vote_average);
    setMapValue(ret, 'title', model.title);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'popularity', model.popularity);
    setMapValue(ret, 'poster_path', model.poster_path);
    setMapValue(ret, 'original_language', model.original_language);
    setMapValue(ret, 'original_title', model.original_title);
    setMapValue(ret, 'backdrop_path', model.backdrop_path);
    setMapValue(ret, 'adult', model.adult);
    setMapValue(ret, 'overview', model.overview);
    setMapValue(ret, 'release_date', model.release_date);
    setMapValue(ret, 'first_air_date', model.first_air_date);
    setMapValue(
        ret,
        'genres',
        codeIterable(
            model.genres, (val) => _genereJsonSerializer.toMap(val as Genre)));
    return ret;
  }

  @override
  Movie fromMap(Map map) {
    if (map == null) return null;
    final obj = Movie();
    obj.vote_count = map['vote_count'] as int;
    obj.id = map['id'] as int;
    obj.vote_average = map['vote_average'] as double;
    obj.title = map['title'] as String;
    obj.name = map['name'] as String;
    obj.popularity = map['popularity'] as double;
    obj.poster_path = map['poster_path'] as String;
    obj.original_language = map['original_language'] as String;
    obj.original_title = map['original_title'] as String;
    obj.backdrop_path = map['backdrop_path'] as String;
    obj.adult = map['adult'] as bool;
    obj.overview = map['overview'] as String;
    obj.release_date = map['release_date'] as String;
    obj.first_air_date = map['first_air_date'] as String;
    obj.genres = codeIterable<Genre>(map['genres'] as Iterable,
        (val) => _genereJsonSerializer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$MovieDetailsJsonSerializer
    implements Serializer<DetailsResponse> {
  Serializer<Genre> __genereJsonSerializer;
  Serializer<Genre> get _genereJsonSerializer =>
      __genereJsonSerializer ??= GenereJsonSerializer();
  @override
  Map<String, dynamic> toMap(DetailsResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'adult', model.adult);
    setMapValue(ret, 'backdrop_path', model.backdrop_path);
    setMapValue(ret, 'budget', model.budget);
    setMapValue(ret, 'homepage', model.homepage);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'original_title', model.original_title);
    setMapValue(ret, 'overview', model.overview);
    setMapValue(ret, 'poster_path', model.poster_path);
    setMapValue(ret, 'release_date', model.release_date);
    setMapValue(ret, 'first_air_date', model.first_air_date);
    setMapValue(ret, 'revenue', model.revenue);
    setMapValue(ret, 'runtime', model.runtime);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'title', model.title);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'tagline', model.tagline);
    setMapValue(ret, 'vote_average', model.vote_average);
    setMapValue(ret, 'popularity', model.popularity);
    setMapValue(ret, 'vote_count', model.vote_count);
    setMapValue(
        ret,
        'genres',
        codeIterable(
            model.genres, (val) => _genereJsonSerializer.toMap(val as Genre)));
    return ret;
  }

  @override
  DetailsResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = DetailsResponse();
    obj.adult = map['adult'] as bool;
    obj.backdrop_path = map['backdrop_path'] as String;
    obj.budget = map['budget'] as int;
    obj.homepage = map['homepage'] as String;
    obj.id = map['id'] as int;
    obj.original_title = map['original_title'] as String;
    obj.overview = map['overview'] as String;
    obj.poster_path = map['poster_path'] as String;
    obj.release_date = map['release_date'] as String;
    obj.first_air_date = map['first_air_date'] as String;
    obj.revenue = map['revenue'] as int;
    obj.runtime = map['runtime'] as int;
    obj.status = map['status'] as String;
    obj.title = map['title'] as String;
    obj.name = map['name'] as String;
    obj.tagline = map['tagline'] as String;
    obj.vote_average = map['vote_average'] as double;
    obj.popularity = map['popularity'] as double;
    obj.vote_count = map['vote_count'] as int;
    obj.genres = codeIterable<Genre>(map['genres'] as Iterable,
        (val) => _genereJsonSerializer.fromMap(val as Map));
    return obj;
  }
}
