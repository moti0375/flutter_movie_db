import 'package:json_annotation/json_annotation.dart';
part 'genre.g.dart';

@JsonSerializable(nullable: true)
class Genre{
  final int id;
  final String name;

  Genre({this.id, this.name});


  @override
  String toString() {
    return 'Genre{id: $id, name: $name}';
  }

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);

}