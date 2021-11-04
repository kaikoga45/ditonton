import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_season.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatus,
  GetTvSeason,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSerios,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetDetailTvSeries;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetTvSeason mockGetTvSeason;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSerios mockRemoveWatchlistTvSerios;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailTvSeries = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetTvSeason = MockGetTvSeason();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSerios = MockRemoveWatchlistTvSerios();
    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetDetailTvSeries,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getTvSeason: mockGetTvSeason,
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlistTvSerios,
      saveWatchlist: mockSaveWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  final tTvSeriesList = <TvSeries>[testTvSeries];

  void _arrangeUsecaseTvSeries() {
    when(mockGetDetailTvSeries.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  final tTvSeriesId = 1;
  final tTotalSeason = 1;
  final tTvSeasonList = testTvSeasonList;

  void _arrangeUsecaseTvSeason() {
    when(mockGetTvSeason.execute(tTvSeriesId, tTotalSeason))
        .thenAnswer((_) async => Right(tTvSeasonList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecaseTvSeries();
      _arrangeUsecaseTvSeason();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetDetailTvSeries.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecaseTvSeries();
      _arrangeUsecaseTvSeason();

      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecaseTvSeries();
      _arrangeUsecaseTvSeason();

      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, testTvSeriesDetail);
      expect(listenerCallCount, 4);
    });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecaseTvSeries();
      _arrangeUsecaseTvSeason();

      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesRecommendations.execute(tId));
      expect(provider.recommendation, tTvSeriesList);
    });

    test(
        'should change tv series recommendation when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecaseTvSeries();
      _arrangeUsecaseTvSeason();

      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.recommendation, tTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      when(mockGetTvSeason.execute(tId, tTotalSeason))
          .thenAnswer((_) async => Left(UnknownFailure('Failed')));

      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Tv Series Watchlist', () {
    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.addWatchlist(testTvSeriesDetail, WatchlistType.TvSeries);
      // assert
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should update error message when save request in successful',
        () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.addWatchlist(testTvSeriesDetail, WatchlistType.TvSeries);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.watchlistMessage, 'Failed');
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvSerios.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.removeFromWatchlist(
          testTvSeriesDetail, WatchlistType.TvSeries);
      // assert
      verify(mockRemoveWatchlistTvSerios.execute(testTvSeriesDetail));
    });

    test('should update error message when remove request in successful',
        () async {
      // arrange
      when(mockRemoveWatchlistTvSerios.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.removeFromWatchlist(
          testTvSeriesDetail, WatchlistType.TvSeries);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.watchlistMessage, 'Failed');
    });

    test('should execute load watchlist when function called', () async {
      // arrange
      when(mockGetWatchListStatus.execute(tId, WatchlistType.TvSeries))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.loadWatchlistStatus(tId, WatchlistType.TvSeries);
      // assert
      verify(mockGetWatchListStatus.execute(tId, WatchlistType.TvSeries));
    });

    test(
        'should update error message when load watchlist request in successful',
        () async {
      // arrange
      when(mockGetWatchListStatus.execute(tId, WatchlistType.TvSeries))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      // act
      await provider.loadWatchlistStatus(tId, WatchlistType.TvSeries);
      // act
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.watchlistMessage, 'Failed');
    });
  });

  group('Get Tv Season', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecaseTvSeason();
      // act
      await provider.fetchTvSeason(tTvSeriesId, tTotalSeason);
      // assert
      verify(mockGetTvSeason.execute(tTvSeriesId, tTotalSeason));
      expect(provider.tvSeason, tTvSeasonList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecaseTvSeason();
      // act
      await provider.fetchTvSeason(tTvSeriesId, tTotalSeason);
      // assert
      expect(provider.tvSeasonState, RequestState.Loaded);
      expect(provider.tvSeason, tTvSeasonList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeason.execute(tTvSeriesId, tTotalSeason))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeason(tTvSeriesId, tTotalSeason);
      // assert
      expect(provider.tvSeasonState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });
}
