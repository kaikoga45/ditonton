import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular_tv_series/popular_tv_series.dart';
import 'package:test/scaffolding.dart';

import 'package:core/core.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc =
        PopularTvSeriesBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  final tTvSeriesList = testTvSeriesList;

  group('Fetch Popular Tv Series', () {
    void arrangeUseCas() {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
    }

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCas();
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      verify: (bloc) async {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        arrangeUseCas();
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesLoaded(tvSeries: tTvSeriesList),
      ],
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should emit [Loading, Error] when data is fetched unsuccessfully',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
    );
  });
}
