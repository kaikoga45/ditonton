import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import 'list_tv_season_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeason,
])
void main() {
  late ListTvSeasonBloc listTvSeasonBloc;
  late MockGetTvSeason mockGetTvSeason;

  setUp(() {
    mockGetTvSeason = MockGetTvSeason();
    listTvSeasonBloc = ListTvSeasonBloc(getTvSeason: mockGetTvSeason);
  });

  final tId = 1;
  final tTotalSeasons = 2;
  final tTvSeasonList = testTvSeasonList;

  group('Fetch List Tv Season', () {
    void arrangeUseCase() {
      when(mockGetTvSeason.execute(tId, tTotalSeasons))
          .thenAnswer((_) async => Right(tTvSeasonList));
    }

    blocTest<ListTvSeasonBloc, ListTvSeasonState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return listTvSeasonBloc;
      },
      act: (bloc) =>
          bloc.add(FetchTvSeason(tvId: tId, totalSeason: tTotalSeasons)),
      verify: (_) {
        verify(mockGetTvSeason.execute(tId, tTotalSeasons));
      },
    );

    blocTest<ListTvSeasonBloc, ListTvSeasonState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return listTvSeasonBloc;
      },
      act: (bloc) =>
          bloc.add(FetchTvSeason(tvId: tId, totalSeason: tTotalSeasons)),
      expect: () => [
        ListTvSeasonLoading(),
        ListTvSeasonLoaded(tvSeasons: tTvSeasonList),
      ],
      verify: (_) {
        verify(mockGetTvSeason.execute(tId, tTotalSeasons));
      },
    );

    blocTest<ListTvSeasonBloc, ListTvSeasonState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTvSeason.execute(tId, tTotalSeasons)).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return listTvSeasonBloc;
      },
      act: (bloc) =>
          bloc.add(FetchTvSeason(tvId: tId, totalSeason: tTotalSeasons)),
      expect: () => [
        ListTvSeasonLoading(),
        ListTvSeasonError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTvSeason.execute(tId, tTotalSeasons));
      },
    );
  });
}
