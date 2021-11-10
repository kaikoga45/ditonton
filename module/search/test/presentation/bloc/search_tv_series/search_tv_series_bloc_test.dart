import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv_series.dart';
import 'package:search/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:test/test.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  SearchTvSeries,
])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(
      searchTvSeries: mockSearchTvSeries,
    );
  });

  final tQuery = 'chucky';
  final tTvSeriesList = testTvSeriesList;

  group('Search Tv Series', () {
    void arrangeUseCase() {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
    }

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should get data from the event',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));

        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchedSearchTvSeries(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      verify: (_) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchedSearchTvSeries(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesLoaded(
          tvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchedSearchTvSeries(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );
  });
}
