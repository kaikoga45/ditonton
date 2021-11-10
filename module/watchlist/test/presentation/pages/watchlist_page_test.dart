import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/watchlist.dart';

class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class WatchlistEventFake extends WatchlistEvent {}

class WatchlistStateFake extends WatchlistState {}

void main() {
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
  });

  setUp(() {
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<WatchlistBloc>(create: (context) => mockWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tWatchlist = <Watchlist>[testWatchlistMovie, testTvSeriesWatchlist];

  group('Watchlist', () {
    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockWatchlistBloc.add(FetchWatchlist())).thenReturn([]);
      when(() => mockWatchlistBloc.state).thenReturn(WatchlistLoading());
      final centerFinder = find.byKey(Key('center_wl'));
      final pogressFinder = find.byKey(Key('progress_wl'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockWatchlistBloc.add(FetchWatchlist()))
          .thenReturn(tWatchlist);
      when(() => mockWatchlistBloc.state)
          .thenReturn(WatchlistLoaded(watchlist: tWatchlist));
      final contentFinder = find.byKey(Key('wl'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockWatchlistBloc.add(FetchWatchlist())).thenReturn([]);
      when(() => mockWatchlistBloc.state)
          .thenReturn(WatchlistError(message: 'error'));
      final textFinder = find.byKey(Key('error_wl'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
