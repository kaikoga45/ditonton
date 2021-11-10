import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchlist usecase;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    usecase = GetTvSeriesWatchlist(repository: repository);
  });

  final tWatchlist = <Watchlist>[testWatchlistMovie];

  test('should return watchlist from repository', () async {
    // arrange
    when(repository.getWatchlist()).thenAnswer((_) async => Right(tWatchlist));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tWatchlist));
  });
}
