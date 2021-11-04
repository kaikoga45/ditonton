import 'dart:convert';

import 'package:ditonton/data/models/tv_season_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final tTvSeasonResponse = testTvSeasonResponse;

  test('should return a valid Tv Season Response model from JSON data',
      () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_season.json'));
    // act
    final result = TvSeasonResponse.fromJson(jsonMap);
    // assert
    expect(result, tTvSeasonResponse);
  });

  test('should return a JSON Tv Season Response map containing proper data',
      () {
    // arrange

    // act
    final result = tTvSeasonResponse.toJson();
    // assert
    final expectedJsonMap = testTvSeasonResponseMap;
    expect(result, expectedJsonMap);
  });
}
