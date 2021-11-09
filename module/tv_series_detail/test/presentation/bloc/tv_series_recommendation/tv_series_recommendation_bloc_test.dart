import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesRecommendations,
])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc = TvSeriesRecommendationBloc(
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations);
  });

  final tId = 1;
  final tTvSeriesRecommendation = testTvSeriesList;

  group('Fetch Tv Series Recommendation', () {
    void arrangeUseCase() {
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
    }

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesRecommendation(tvSeriesId: tId)),
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesRecommendation(tvSeriesId: tId)),
      expect: () => [
        TvSeriesRecommendationLoading(),
        TvSeriesRecommendationLoaded(tvSeries: tTvSeriesRecommendation),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesRecommendation(tvSeriesId: tId)),
      expect: () => [
        TvSeriesRecommendationLoading(),
        TvSeriesRecommendationError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
  });
}
