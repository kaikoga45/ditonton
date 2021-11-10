import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesWatchListStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSerios
])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockGetTvSeriesWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSerios mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchListStatus = MockGetTvSeriesWatchListStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSerios();

    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  final tId = 1;
  final tWatchlistStatus = true;
  final tWatchlisType = WatchlistType.TvSeries;
  final tTvSeriesDetail = testTvSeriesDetail;

  group('Load Watchlist Status', () {
    void arrangeLoadUseCase() {
      when(mockGetWatchListStatus.execute(tId, tWatchlisType))
          .thenAnswer((_) async => Right(tWatchlistStatus));
    }

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeLoadUseCase();
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(
          LoadWatchlistStatus(tvSeriesId: tId, watchlistType: tWatchlisType)),
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId, tWatchlisType));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeLoadUseCase();
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(
          LoadWatchlistStatus(tvSeriesId: tId, watchlistType: tWatchlisType)),
      expect: () => [
        TvSeriesWatchlistLoading(),
        TvSeriesWatchlistLoaded(watchlistStatus: tWatchlistStatus),
      ],
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId, tWatchlisType));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetWatchListStatus.execute(tId, tWatchlisType)).thenAnswer(
            (_) async => Left(DatabaseFailure('DATABASE_FAILURE_MESSAGE')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(
          LoadWatchlistStatus(tvSeriesId: tId, watchlistType: tWatchlisType)),
      expect: () => [
        TvSeriesWatchlistLoading(),
        TvSeriesWatchlistError(message: 'DATABASE_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId, tWatchlisType));
      },
    );
  });

  group('Add Tv Series Watchlist', () {
    void arrangeAddUseCase() {
      when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => Right('Success Adding'));
    }

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeAddUseCase();
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail)),
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeAddUseCase();
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail)),
      expect: () => [
        TvSeriesWatchlistLoading(),
        TvSeriesWatchlistLoaded(watchlistStatus: tWatchlistStatus),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('DATABASE_FAILURE_MESSAGE')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail)),
      expect: () => [
        TvSeriesWatchlistLoading(),
        TvSeriesWatchlistError(message: 'DATABASE_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail));
      },
    );
  });

  group('Remove Tv Series Watchlist', () {
    void arrangeRemoveUseCase() {
      when(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => Right('Success Remove'));
    }

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeRemoveUseCase();
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesWatchlist(
        tvSeriesDetail: tTvSeriesDetail,
        watchlistType: tWatchlisType,
      )),
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeRemoveUseCase();
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesWatchlist(
        tvSeriesDetail: tTvSeriesDetail,
        watchlistType: tWatchlisType,
      )),
      expect: () => [
        TvSeriesWatchlistLoading(),
        TvSeriesWatchlistLoaded(watchlistStatus: !tWatchlistStatus),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('DATABASE_FAILURE_MESSAGE')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesWatchlist(
          tvSeriesDetail: tTvSeriesDetail, watchlistType: tWatchlisType)),
      expect: () => [
        TvSeriesWatchlistLoading(),
        TvSeriesWatchlistError(message: 'DATABASE_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail));
      },
    );
  });
}
