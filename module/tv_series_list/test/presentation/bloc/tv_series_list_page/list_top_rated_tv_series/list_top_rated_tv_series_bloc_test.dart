import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_list/tv_series_list.dart';

import 'list_top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetListTopRatedTvSeries])
void main() {
  late ListTopRatedTvSeriesBloc listTopRatedTvSeriesBloc;
  late MockGetListTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetListTopRatedTvSeries();
    listTopRatedTvSeriesBloc =
        ListTopRatedTvSeriesBloc(getTopRatedTvSeries: mockGetTopRatedTvSeries);
  });

  final tTvSeriesList = testTvSeriesList;

  group('Fetch List Top Rated Tv Series', () {
    void arrangeUseCase() {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
    }

    blocTest<ListTopRatedTvSeriesBloc, ListTopRatedTvSeriesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return listTopRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchListTopRatedTvSeries()),
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<ListTopRatedTvSeriesBloc, ListTopRatedTvSeriesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return listTopRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchListTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesLoaded(tvSeries: tTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<ListTopRatedTvSeriesBloc, ListTopRatedTvSeriesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return listTopRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchListTopRatedTvSeries()),
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
