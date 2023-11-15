import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_list/presentation/bloc/list_now_playing_movies/list_now_playing_movies_bloc.dart';

import 'list_now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetListNowPlayingMovies,
])
void main() {
  late ListNowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetListNowPlayingMovies mockGetNowPlayingMovie;

  setUp(() {
    mockGetNowPlayingMovie = MockGetListNowPlayingMovies();
    nowPlayingMoviesBloc = ListNowPlayingMoviesBloc(
      getNowPlayingMovies: mockGetNowPlayingMovie,
    );
  });

  final tMovieList = testMovieList;

  group('Fetch List Now Playing Movies', () {
    void arrangeUseCase() {
      when(mockGetNowPlayingMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
    }

    blocTest<ListNowPlayingMoviesBloc, ListNowPlayingMoviesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListNowPlayingMovies()),
      verify: (_) {
        verify(mockGetNowPlayingMovie.execute());
      },
    );

    blocTest<ListNowPlayingMoviesBloc, ListNowPlayingMoviesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListNowPlayingMovies()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesLoaded(movies: tMovieList),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovie.execute());
      },
    );

    blocTest<ListNowPlayingMoviesBloc, ListNowPlayingMoviesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetNowPlayingMovie.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListNowPlayingMovies()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovie.execute());
      },
    );
  });
}
