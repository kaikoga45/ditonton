import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import 'get_watchlist_test.mocks.dart';

@GenerateMocks([WatchlistRepository])
void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    usecase = GetWatchlist(repository: repository);
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
