import 'package:flutter_test/flutter_test.dart';

import 'package:core/core.dart';

void main() {
  final tTvSeriesTabel = testTvSeriesTable;

  final tTvSeriesTableMap = testWathlistTvSeriesMap;

  final tTvSeriesWatchlistEntity = testTvSeriesWatchlistEntity;

  final tTvSeriesDetail = testTvSeriesDetail;

  test(
      'should return a Tv Series Wathclist entity when convert from tv series table model',
      () {
    final result = tTvSeriesTabel.toEntity();
    expect(result, tTvSeriesWatchlistEntity);
  });

  test(
      'should return JSON tv series table when convert from tv series table model',
      () {
    final result = tTvSeriesTabel.toJson();
    expect(result, tTvSeriesTableMap);
  });

  test(
      'should be a subclass of Tv Series Table when convert from tv series detail entity',
      () {
    final result = TvSeriesTable.fromEntity(tTvSeriesDetail);
    expect(result, tTvSeriesTabel);
  });

  test(
      'should be a subclass of Tv Series Table when convert from tv series detail map',
      () {
    final result = TvSeriesTable.fromMap(tTvSeriesTableMap);
    expect(result, tTvSeriesTabel);
  });
}
