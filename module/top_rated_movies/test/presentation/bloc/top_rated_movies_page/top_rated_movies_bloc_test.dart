import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:top_rated_movies/top_rated_movies.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc =
        TopRatedMoviesBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  final tMovieList = testMovieList;

  group('Fetch Top Rated Movies', () {
    void arrangeUseCase() {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
    }

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesLoaded(movies: tMovieList),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
