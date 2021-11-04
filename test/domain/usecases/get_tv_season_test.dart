import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/usecases/get_tv_season.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeason usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTvSeason(repository: repository);
  });

  final tId = 1;
  final tTotalSeason = 1;
  final tTvSeason = <TvSeason>[testTvSeason];

  test('should get list of tv season from repository', () async {
    // arrange
    when(repository.getTvSeason(tId, tTotalSeason))
        .thenAnswer((_) async => Right(tTvSeason));
    // act
    final result = await usecase.execute(tId, tTotalSeason);
    // assert
    expect(result, Right(tTvSeason));
  });
}
