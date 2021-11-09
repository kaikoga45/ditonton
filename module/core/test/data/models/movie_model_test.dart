import 'package:core/core.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: true,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: true,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieMap = testMovieMap;

  test('should return a Movie entity when convert from movie model', () {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should return a JSON movie map when convert from movie model', () {
    final result = tMovieModel.toJson();
    expect(result, tMovieMap);
  });

  test('should return a Movie model when convert from json data', () {
    final result = MovieModel.fromJson(tMovieMap);
    expect(result, tMovieModel);
  });
}
