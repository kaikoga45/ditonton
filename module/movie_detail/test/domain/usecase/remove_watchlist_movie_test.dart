import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecase;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    usecase = RemoveWatchlistMovie(repository: repository);
  });

  test('should return success message when watchlist movie being removed',
      () async {
    // arrange
    when(repository.removeWatchlistMovies(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    expect(result, Right('Removed from Watchlist'));
  });
}
