import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTvSeriesDetailMap = testTvSeriesDetailMap;
  final tTvSeriesDetailModel = testTvSeriesDetailModel;
  final tTvSeriesDetail = testTvSeriesDetail;

  test('should return a tv series detail model', () {
    final result = TvSeriesDetailResponse.fromJson(testTvSeriesDetailMap);
    expect(result, testTvSeriesDetailModel);
  });

  test('should be a subclass of Tv Series Detail entity', () {
    final result = tTvSeriesDetailModel.toEntity();
    expect(result, tTvSeriesDetail);
  });

  test('should return a JSON tv series detail map', () {
    final result = tTvSeriesDetailModel.toJson();
    expect(result, tTvSeriesDetailMap);
  });
}
