import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_list/tv_series_list.dart';

import 'list_popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetListPopularTvSeries])
void main() {
  late ListPopularTvSeriesBloc listPopularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    listPopularTvSeriesBloc =
        ListPopularTvSeriesBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  final tTvSeriesList = testTvSeriesList;

  group('Fetch List Popular Tv Series', () {
    void arrangeUseCas() {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
    }

    blocTest<ListPopularTvSeriesBloc, ListPopularTvSeriesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCas();
        return listPopularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchListPopularTvSeries()),
      verify: (bloc) async {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<ListPopularTvSeriesBloc, ListPopularTvSeriesState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        arrangeUseCas();
        return listPopularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchListPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesLoaded(tvSeries: tTvSeriesList),
      ],
    );

    blocTest<ListPopularTvSeriesBloc, ListPopularTvSeriesState>(
      'should emit [Loading, Error] when data is fetched unsuccessfully',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return listPopularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchListPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
    );
  });
}
