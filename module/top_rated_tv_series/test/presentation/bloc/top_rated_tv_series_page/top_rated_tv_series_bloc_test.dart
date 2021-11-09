import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:top_rated_tv_series/top_rated_tv_series.dart';

import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc =
        TopRatedTvSeriesBloc(getTopRatedTvSeries: mockGetTopRatedTvSeries);
  });

  final tTvSeriesList = testTvSeriesList;

  group('Fetch Top Rated Tv Series', () {
    void arrangeUseCase() {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
    }

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesLoaded(tvSeries: tTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
