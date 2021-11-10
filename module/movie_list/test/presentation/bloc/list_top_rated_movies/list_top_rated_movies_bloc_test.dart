import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_list/presentation/bloc/list_top_rated_movies/list_top_rated_movies_bloc.dart';
import 'package:test/test.dart';

import 'list_top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetListTopRatedMovies,
])
void main() {
  late ListTopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetListTopRatedMovies mockGetTopRatedMovie;

  setUp(() {
    mockGetTopRatedMovie = MockGetListTopRatedMovies();
    topRatedMoviesBloc = ListTopRatedMoviesBloc(
      getTopRatedMovies: mockGetTopRatedMovie,
    );
  });

  final tMovieList = testMovieList;

  group('Fetch List Top Rated Movies', () {
    void arrangeUseCase() {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
    }

    blocTest<ListTopRatedMoviesBloc, ListTopRatedMoviesState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListTopRatedMovies()),
      verify: (_) {
        verify(mockGetTopRatedMovie.execute());
      },
    );

    blocTest<ListTopRatedMoviesBloc, ListTopRatedMoviesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListTopRatedMovies()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesLoaded(movies: tMovieList),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovie.execute());
      },
    );

    blocTest<ListTopRatedMoviesBloc, ListTopRatedMoviesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTopRatedMovie.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchListTopRatedMovies()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovie.execute());
      },
    );
  });
}
