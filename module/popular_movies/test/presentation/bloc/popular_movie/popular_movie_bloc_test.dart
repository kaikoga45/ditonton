import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular_movies/popular_movies.dart';
import 'package:test/scaffolding.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc =
        PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
  });

  final tMoviesList = testMovieList;

  group('Fetch Popular Movies', () {
    void arrangeUseCas() {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMoviesList));
    }

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCas();
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      verify: (bloc) async {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        arrangeUseCas();
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesLoaded(movies: tMoviesList),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit [Loading, Error] when data is fetched unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
    );
  });
}
