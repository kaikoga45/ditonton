import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchListStatus usecase;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    usecase = GetTvSeriesWatchListStatus(repository: repository);
  });

  final tId = 1;

  group('Get Watchlist Status', () {
    test('should return true for watchlist movie status from repository',
        () async {
      // arrange
      when(repository.isAddedToWatchlist(tId, WatchlistType.Movie))
          .thenAnswer((_) async => Right(true));
      // act
      final result = await usecase.execute(tId, WatchlistType.Movie);
      // assert
      expect(result, Right(true));
    });

    test('should return false for watchlist movie status from repository',
        () async {
      // arrange
      when(repository.isAddedToWatchlist(tId, WatchlistType.Movie))
          .thenAnswer((_) async => Right(false));
      // act
      final result = await usecase.execute(tId, WatchlistType.Movie);
      // assert
      expect(result, Right(false));
    });

    test('should return true for watchlist tv series status from repository',
        () async {
      // arrange
      when(repository.isAddedToWatchlist(tId, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(true));
      // act
      final result = await usecase.execute(tId, WatchlistType.TvSeries);
      // assert
      expect(result, Right(true));
    });

    test('should return false for watchlist tv series status from repository',
        () async {
      // arrange
      when(repository.isAddedToWatchlist(tId, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(false));
      // act
      final result = await usecase.execute(tId, WatchlistType.TvSeries);
      // assert
      expect(result, Right(false));
    });
  });
}
