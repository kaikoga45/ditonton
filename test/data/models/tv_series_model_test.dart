import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTvSeriesModel = testTvSeriesModel;

  final tTvSeries = testTvSeries;

  final tTvSeriesMap = testTvSeriesMap;

  test('should return a Tv Series entity when convert from tv series model',
      () {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });

  test('should return a JSON tv series map when convert from tv series model',
      () {
    final result = tTvSeriesModel.toJson();
    expect(result, tTvSeriesMap);
  });

  test('should return a Tv Series model when convert from json data', () {
    final result = TvSeriesModel.fromJson(tTvSeriesMap);
    expect(result, tTvSeriesModel);
  });
}
