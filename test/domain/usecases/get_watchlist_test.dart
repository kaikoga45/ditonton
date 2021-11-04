import 'package:dartz/dartz.dart';

import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

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
