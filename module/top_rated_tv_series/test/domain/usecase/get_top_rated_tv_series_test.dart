import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:top_rated_tv_series/top_rated_tv_series.dart';

import 'get_top_rated_tv_series_test.mocks.dart';

@GenerateMocks([TvSeriesRepository])
void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(repository: repository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of top rated tv series from repository', () async {
    // arrange
    when(repository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
