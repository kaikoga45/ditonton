import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc =
        TvSeriesDetailBloc(getTvSeriesDetail: mockGetTvSeriesDetail);
  });

  final tId = 1;
  final tTvSeriesDetail = testTvSeriesDetail;

  group('Fetch Tv Series Detail', () {
    void arrangeUseCase() {
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
    }

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      expect: () => [
        TvSeriesDetailLoading(),
        TvSeriesDetailLoaded(tvSeriesDetail: tTvSeriesDetail),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      expect: () => [
        TvSeriesDetailLoading(),
        TvSeriesDetailError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );
  });
}
