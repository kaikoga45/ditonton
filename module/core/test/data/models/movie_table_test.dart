import 'package:core/core.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTabel = testMovieTable;

  final tMovieTableMap = testMovieTableMap;

  final tMovieWatchlist = Movie.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  final tMovieDetail = testMovieDetail;

  test(
      'should return a Movie Wathclist entity when convert from movie table model',
      () {
    final result = tMovieTabel.toEntity();
    expect(result, tMovieWatchlist);
  });

  test('should return JSON movie table when convert from movie table model',
      () {
    final result = tMovieTabel.toJson();
    expect(result, tMovieTableMap);
  });

  test(
      'should be a subclass of Movie Table when convert from movie detail entity',
      () {
    final result = MovieTable.fromEntity(tMovieDetail);
    expect(result, tMovieTabel);
  });

  test('should be a subclass of Movie Table when convert from movie detail map',
      () {
    final result = MovieTable.fromMap(tMovieTableMap);
    expect(result, tMovieTabel);
  });
}
