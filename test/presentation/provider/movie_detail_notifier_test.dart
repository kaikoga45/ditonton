import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  late MovieDetailNotifier provider;
  late MockGetMovieDetail mockGetDetailMovie;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailMovie = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    provider = MovieDetailNotifier(
        getMovieDetail: mockGetDetailMovie,
        getMovieRecommendations: mockGetMovieRecommendations,
        getWatchListStatus: mockGetWatchListStatus,
        removeWatchlist: mockRemoveWatchlistMovie,
        saveWatchlist: mockSaveWatchlistMovie)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  final tMovieList = <Movie>[testMovie];

  final tMovieDetail = testMovieDetail;

  void _arrangeUsecase() {
    when(mockGetDetailMovie.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovieList));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      verify(mockGetDetailMovie.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movie, testMovieDetail);
      expect(listenerCallCount, 3);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      verify(mockGetMovieRecommendations.execute(tId));
      expect(provider.movieRecommendations, tMovieList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovieList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetDetailMovie.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Movie Watchlist', () {
    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.Movie))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.addWatchlist(testMovieDetail, WatchlistType.Movie);
      // assert
      verify(mockSaveWatchlistMovie.execute(testMovieDetail));
    });

    test('should update error message when save request in successful',
        () async {
      // arrange
      when(mockSaveWatchlistMovie.execute(tMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.Movie))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.addWatchlist(tMovieDetail, WatchlistType.Movie);
      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.watchlistMessage, 'Failed');
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.Movie))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.removeFromWatchlist(testMovieDetail, WatchlistType.Movie);
      // assert
      verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
    });

    test('should update error message when remove request in successful',
        () async {
      // arrange
      when(mockRemoveWatchlistMovie.execute(tMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(
              testMovieDetail.id, WatchlistType.Movie))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.removeFromWatchlist(tMovieDetail, WatchlistType.Movie);
      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.watchlistMessage, 'Failed');
    });

    test('should execute load watchlist when function called', () async {
      // arrange
      when(mockGetWatchListStatus.execute(tId, WatchlistType.Movie))
          .thenAnswer((_) async => Right(true));
      // act
      await provider.loadWatchlistStatus(tId, WatchlistType.Movie);
      // assert
      verify(mockGetWatchListStatus.execute(tId, WatchlistType.Movie));
    });

    test(
        'should update error message when load watchlist request in successful',
        () async {
      // arrange
      when(mockGetWatchListStatus.execute(tId, WatchlistType.Movie))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      // act
      await provider.loadWatchlistStatus(tId, WatchlistType.Movie);
      // act
      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.watchlistMessage, 'Failed');
    });
  });
}
