import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:watchlist/watchlist.dart';

import 'wathclist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlist,
])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlist mockGetWatchlist;

  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(getWatchlist: mockGetWatchlist);
  });

  final tWatchlist = <Watchlist>[testWatchlistMovie, testTvSeriesWatchlist];

  group('Fetch Watchlist', () {
    void arrangeUseCase() {
      when(mockGetWatchlist.execute())
          .thenAnswer((_) async => Right(tWatchlist));
    }

    blocTest<WatchlistBloc, WatchlistState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist()),
      verify: (_) {
        verify(mockGetWatchlist.execute());
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist()),
      expect: () => [
        WatchlistLoading(),
        WatchlistLoaded(watchlist: tWatchlist),
      ],
      verify: (_) {
        verify(mockGetWatchlist.execute());
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetWatchlist.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist()),
      expect: () => [
        WatchlistLoading(),
        WatchlistError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetWatchlist.execute());
      },
    );
  });
}
