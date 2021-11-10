import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetListTopRatedTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetListTopRatedTvSeries(repository: repository);
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
