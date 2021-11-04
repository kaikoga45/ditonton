import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = testTvSeriesModel;
  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  test('should return a valid Tv Series Response model from JSON data',
      () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_on_air.json'));
    // act
    final result = TvSeriesResponse.fromJson(jsonMap);
    // assert
    expect(result, tTvSeriesResponseModel);
  });

  test('should return a JSON Tv Series Response map containing proper data',
      () {
    // arrange

    // act
    final result = tTvSeriesResponseModel.toJson();
    // assert
    final expectedJsonMap = {
      "results": [
        {
          "backdrop_path": "backdropPath",
          "first_air_date": "firstAirDate",
          "genre_ids": [],
          "id": 1,
          "name": "name",
          "origin_country": [],
          "original_language": "originalLanguage",
          "original_name": "originalName",
          "overview": "overview",
          "popularity": 1,
          "poster_path": "posterPath",
          "vote_average": 1,
          "vote_count": 1
        }
      ],
    };
    expect(result, expectedJsonMap);
  });
}
