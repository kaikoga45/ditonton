import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = testMovieDetailModel;

  final tMovieDetail = testMovieDetail;

  final tMovieDetailMap = testMovieDetailMap;

  test('should return a movie detail model', () {
    final result = MovieDetailResponse.fromJson(tMovieDetailMap);
    expect(result, tMovieDetailModel);
  });

  test('should be a subclass of Movie Detail entity', () {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });

  test('should return a JSON movie detail map', () {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailMap);
  });
}
