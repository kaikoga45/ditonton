import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:test/test.dart';

import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  final tId = 1;
  final tMovieList = testMovieList;

  group('Fetch Movie Recommendation', () {
    void arrangeUseCase() {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
    }

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchMovieRecommendation(movieId: tId)),
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchMovieRecommendation(movieId: tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationLoaded(movies: tMovieList),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchMovieRecommendation(movieId: tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });
}
