import 'package:dartz/dartz.dart';

import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistMovie usecase;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    usecase = SaveWatchlistMovie(repository: repository);
  });

  test('should return success message when watchlist movie being saved',
      () async {
    // arrange
    when(repository.saveWatchlistMovies(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    expect(result, Right('Added to Watchlist'));
  });
}
