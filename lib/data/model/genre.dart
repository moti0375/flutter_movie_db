import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre extends Equatable {
  final int id;
  final String name;

  Genre({required this.id, required this.name});


  @override
  String toString() {
    return 'Genre{id: $id, name: $name}';
  }

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);

  @override
  List<Object> get props => [id, name];

}