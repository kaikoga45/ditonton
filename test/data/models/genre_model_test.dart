import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');
  final tGenre = Genre(id: 1, name: 'name');
  final tGenreJson = {
    "id": 1,
    "name": "name",
  };

  test(
    'should return a subclass Genre model when convert from json data',
    () {
      final result = GenreModel.fromJson(tGenreJson);
      expect(result, tGenreModel);
    },
  );

  test('should return a JSON map when convert from genre model', () {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });

  test('should return Genre entity from genre model', () {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}
