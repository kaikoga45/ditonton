import 'package:ditonton/data/models/episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tEpisodeModel = testEpisodeModel;
  final tEpisode = testEpisode;
  final tEpisodeMap = testEpisodeMap;

  test(
    'should return a subclass Episode model when convert from json data',
    () {
      final result = EpisodeModel.fromJson(tEpisodeMap);
      expect(result, tEpisodeModel);
    },
  );

  test('should return a JSON map when convert from episode model', () {
    final result = tEpisodeModel.toJson();
    expect(result, tEpisodeMap);
  });

  test('should return Episode entity from episode model', () {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}
