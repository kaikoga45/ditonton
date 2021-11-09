import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:test/test.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
    );
  });

  final tId = 1;
  final tMovieDetail = testMovieDetail;

  group('Fetch Movie Detail', () {
    void arrangeUseCase() {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(tMovieDetail));
    }

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailLoaded(
          movie: tMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });
}
