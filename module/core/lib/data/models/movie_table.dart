import 'package:core/core.dart';

import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String? overview;
  final String type;

  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    this.type = 'movie',
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'posterPath': posterPath,
        'type': type,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
        type,
      ];
}
