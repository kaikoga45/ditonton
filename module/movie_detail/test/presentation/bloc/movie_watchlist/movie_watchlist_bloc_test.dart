import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:test/test.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetMovieWatchListStatus, SaveWatchlistMovie, RemoveWatchlistMovie])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();

    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlistMovie: mockSaveWatchlistMovie,
      removeWatchlistMovie: mockRemoveWatchlistMovie,
    );
  });

  final tId = 1;
  final tWatchlistStatus = true;
  final tWatchlisType = WatchlistType.Movie;
  final tMovieDetail = testMovieDetail;

  group('Load Watchlist Status', () {
    void arrangeLoadUseCase() {
      when(mockGetWatchListStatus.execute(tId, tWatchlisType))
          .thenAnswer((_) async => Right(tWatchlistStatus));
    }

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeLoadUseCase();
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc
          .add(LoadWatchlistStatus(movieId: tId, watchlistType: tWatchlisType)),
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId, tWatchlisType));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeLoadUseCase();
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc
          .add(LoadWatchlistStatus(movieId: tId, watchlistType: tWatchlisType)),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistLoaded(watchlistStatus: tWatchlistStatus),
      ],
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId, tWatchlisType));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetWatchListStatus.execute(tId, tWatchlisType)).thenAnswer(
            (_) async => Left(DatabaseFailure('DATABASE_FAILURE_MESSAGE')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc
          .add(LoadWatchlistStatus(movieId: tId, watchlistType: tWatchlisType)),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistError(message: 'DATABASE_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId, tWatchlisType));
      },
    );
  });

  group('Add Movie Watchlist', () {
    void arrangeAddUseCase() {
      when(mockSaveWatchlistMovie.execute(tMovieDetail))
          .thenAnswer((_) async => Right('Success Adding'));
    }

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeAddUseCase();
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(movieDetail: tMovieDetail)),
      verify: (_) {
        verify(mockSaveWatchlistMovie.execute(tMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeAddUseCase();
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(movieDetail: tMovieDetail)),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistLoaded(watchlistStatus: tWatchlistStatus),
      ],
      verify: (_) {
        verify(mockSaveWatchlistMovie.execute(tMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockSaveWatchlistMovie.execute(tMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('DATABASE_FAILURE_MESSAGE')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(movieDetail: tMovieDetail)),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistError(message: 'DATABASE_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistMovie.execute(tMovieDetail));
      },
    );
  });

  group('Remove Movie Watchlist', () {
    void arrangeRemoveUseCase() {
      when(mockRemoveWatchlistMovie.execute(tMovieDetail))
          .thenAnswer((_) async => Right('Success Remove'));
    }

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeRemoveUseCase();
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieWatchlist(
        movieDetail: tMovieDetail,
        watchlistType: tWatchlisType,
      )),
      verify: (_) {
        verify(mockRemoveWatchlistMovie.execute(tMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeRemoveUseCase();
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieWatchlist(
        movieDetail: tMovieDetail,
        watchlistType: tWatchlisType,
      )),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistLoaded(watchlistStatus: !tWatchlistStatus),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistMovie.execute(tMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockRemoveWatchlistMovie.execute(tMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('DATABASE_FAILURE_MESSAGE')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieWatchlist(
          movieDetail: tMovieDetail, watchlistType: tWatchlisType)),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistError(message: 'DATABASE_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistMovie.execute(tMovieDetail));
      },
    );
  });
}
