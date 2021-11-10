import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:test/test.dart';

import 'search_movies_bloc_test.mocks.dart';

@GenerateMocks([
  SearchMovies,
])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(
      searchMovies: mockSearchMovies,
    );
  });

  final tQuery = 'spiderman';
  final tMovieList = testMovieList;

  group('Search Movies', () {
    void arrangeUseCase() {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
    }

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'should get data from the event',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));

        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchedSearchMovies(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchedSearchMovies(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMoviesLoading(),
        SearchMoviesLoaded(
          movies: tMovieList,
        ),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchedSearchMovies(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMoviesLoading(),
        SearchMoviesError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
