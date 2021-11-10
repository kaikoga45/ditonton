import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/domain/usecases/get_popular_movies.dart';
import 'package:movie_list/presentation/bloc/list_popular_movies/list_popular_movies_bloc.dart';
import 'package:test/test.dart';
import 'list_popular_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetListPopularMovies,
])
void main() {
  late ListPopularMoviesBloc popularMoviesBloc;
  late MockGetListPopularMovies mockGetPopularMovie;

  setUp(() {
    mockGetPopularMovie = MockGetListPopularMovies();
    popularMoviesBloc = ListPopularMoviesBloc(
      getPopularMovies: mockGetPopularMovie,
    );
  });

  final tMovieList = testMovieList;

  group('Fetch List Popular Movies', () {
    void arrangeUseCase() {
      when(mockGetPopularMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
    }

    blocTest<ListPopularMoviesBloc, ListPopularMoviesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListPopularMovies()),
      verify: (_) {
        verify(mockGetPopularMovie.execute());
      },
    );

    blocTest<ListPopularMoviesBloc, ListPopularMoviesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListPopularMovies()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesLoaded(movies: tMovieList),
      ],
      verify: (_) {
        verify(mockGetPopularMovie.execute());
      },
    );

    blocTest<ListPopularMoviesBloc, ListPopularMoviesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetPopularMovie.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListPopularMovies()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetPopularMovie.execute());
      },
    );
  });
}
