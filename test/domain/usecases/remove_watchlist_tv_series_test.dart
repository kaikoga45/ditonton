import 'package:dartz/dartz.dart';

import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSerios usecase;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    usecase = RemoveWatchlistTvSerios(repository: repository);
  });

  test('should return success message when watchlist tv series being removed',
      () async {
    // arrange
    when(repository.removeWatchlistTvSeries(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    expect(result, Right('Removed from Watchlist'));
  });
}
