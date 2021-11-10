import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class TvSeriesDetailEventFake extends Fake implements TvSeriesDetailEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesDetailState {}

class MockTvSeriesWatchlistBloc
    extends MockBloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState>
    implements TvSeriesWatchlistBloc {}

class TvSeriesWatchlistEventFake extends Fake
    implements TvSeriesWatchlistEvent {}

class TvSeriesWatchlistStateFake extends Fake
    implements TvSeriesWatchlistState {}

class MockTvSeasonBloc extends MockBloc<ListTvSeasonEvent, ListTvSeasonState>
    implements ListTvSeasonBloc {}

class ListTvSeasonEventFake extends Fake implements ListTvSeasonEvent {}

class ListTvSeasonStateFake extends Fake implements ListTvSeasonState {}

class MockTvSeriesRecommendation
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}

class TvSeriesRecommendationEventFake extends Fake
    implements TvSeriesRecommendationEvent {}

class TvSeriesRecommendationStateFake extends Fake
    implements TvSeriesRecommendationState {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesWatchlistBloc mockTvSeriesWatchlistBloc;
  late MockTvSeasonBloc mockTvSeasonBloc;
  late MockTvSeriesRecommendation mockTvSeriesRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
    registerFallbackValue(TvSeriesWatchlistEventFake());
    registerFallbackValue(TvSeriesWatchlistStateFake());
    registerFallbackValue(ListTvSeasonEventFake());
    registerFallbackValue(ListTvSeasonStateFake());
    registerFallbackValue(TvSeriesRecommendationEventFake());
    registerFallbackValue(TvSeriesRecommendationStateFake());
  });

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesWatchlistBloc = MockTvSeriesWatchlistBloc();
    mockTvSeasonBloc = MockTvSeasonBloc();
    mockTvSeriesRecommendationBloc = MockTvSeriesRecommendation();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesWatchlistBloc>(
          create: (context) => mockTvSeriesWatchlistBloc,
        ),
        BlocProvider<ListTvSeasonBloc>(
          create: (context) => mockTvSeasonBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (context) => mockTvSeriesRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tId = 1;
  final tTvSeriesDetail = testTvSeriesDetail;
  final tTotalSeason = 2;
  final tTvSeasonList = testTvSeasonList;

  group('TvSeries Detail Bloc', () {
    void _makeStubBloc() {
      when(() => mockTvSeriesWatchlistBloc.add(any())).thenReturn(null);
      when(() => mockTvSeasonBloc.add(any())).thenReturn(null);
      when(() => mockTvSeriesWatchlistBloc.state)
          .thenReturn(TvSeriesWatchlistLoading());
      when(() => mockTvSeasonBloc.state).thenReturn(ListTvSeasonLoading());
      when(() => mockTvSeriesRecommendationBloc.add(any())).thenReturn(null);
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(TvSeriesRecommendationLoading());
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailLoading());
      final centerFinder = find.byType(Center);
      final circularFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(circularFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(id: tId)))
          .thenReturn(tTvSeriesDetail);
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailLoaded(tvSeriesDetail: tTvSeriesDetail));
      _makeStubBloc();
      final safeAreaFinder = find.byType(SafeArea);
      final detailContentFinder = find.byType(DetailContent);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(safeAreaFinder, findsOneWidget);
      expect(detailContentFinder, findsOneWidget);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailError(message: 'Error'));

      final textFinder = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });

  group('TvSeries Watchlist Bloc', () {
    void _makeStubBloc() {
      when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(id: tId)))
          .thenReturn(tTvSeriesDetail);
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailLoaded(tvSeriesDetail: tTvSeriesDetail));
      when(() => mockTvSeasonBloc.add(any())).thenReturn(null);
      when(() => mockTvSeasonBloc.state).thenReturn(ListTvSeasonLoading());
      when(() => mockTvSeriesRecommendationBloc.add(any())).thenReturn(null);
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(TvSeriesRecommendationLoading());
    }

    testWidgets('should display loading ui when being load watchlist status',
        (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockTvSeriesWatchlistBloc.add(LoadWatchlistStatus(
            tvSeriesId: tId,
            watchlistType: WatchlistType.TvSeries,
          ))).thenReturn(TvSeriesWatchlistLoading());
      when(() => mockTvSeriesWatchlistBloc.state)
          .thenReturn(TvSeriesWatchlistLoading());

      final centerFinder = find.byKey(Key('center_tvm'));
      final circularFinder = find.byKey(Key('cpi_tvm'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(circularFinder, findsOneWidget);
    });

    testWidgets(
        'should display check watchlist button when watchlist status equal true',
        (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockTvSeriesWatchlistBloc
              .add(AddTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail)))
          .thenReturn(tTvSeriesDetail);
      when(() => mockTvSeriesWatchlistBloc.state)
          .thenReturn(TvSeriesWatchlistLoaded(watchlistStatus: true));
      final watchlistButtonFinder = find.byKey(Key('watchlist_button_tvm'));
      final checkFinder = find.byKey(Key('check_tvm'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(watchlistButtonFinder, findsOneWidget);
      expect(checkFinder, findsOneWidget);
    });

    testWidgets(
        'should display add watchlist button when watchlist status equal false',
        (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockTvSeriesWatchlistBloc.add(RemoveTvSeriesWatchlist(
            tvSeriesDetail: tTvSeriesDetail,
            watchlistType: WatchlistType.TvSeries,
          ))).thenReturn(tTvSeriesDetail);
      when(() => mockTvSeriesWatchlistBloc.state)
          .thenReturn(TvSeriesWatchlistLoaded(watchlistStatus: false));
      final watchlistButtonFinder = find.byKey(Key('watchlist_button_tvm'));
      final addFinder = find.byKey(Key('add_tvm'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(watchlistButtonFinder, findsOneWidget);
      expect(addFinder, findsOneWidget);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockTvSeriesWatchlistBloc.state)
          .thenReturn(TvSeriesWatchlistError(message: 'Error'));

      final textFinder = find.byKey(Key('error_tvm'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });

  group('List Tv Season Bloc', () {
    void initalizeStub() {
      when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(id: tId)))
          .thenReturn(tTvSeriesDetail);
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailLoaded(tvSeriesDetail: tTvSeriesDetail));
      when(() => mockTvSeriesWatchlistBloc.add(any())).thenReturn(null);
      when(() => mockTvSeriesWatchlistBloc.state)
          .thenReturn(TvSeriesWatchlistLoading());
      when(() => mockTvSeriesRecommendationBloc.add(any())).thenReturn(null);
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(TvSeriesRecommendationLoading());
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      initalizeStub();
      when(() => mockTvSeasonBloc.state).thenReturn(ListTvSeasonLoading());
      final centerFinder = find.byKey(Key('center_tvs'));
      final circularFinder = find.byKey(Key('cpi_tvs'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(circularFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      initalizeStub();

      when(() => mockTvSeasonBloc
              .add(FetchTvSeason(tvId: tId, totalSeason: tTotalSeason)))
          .thenReturn(tTvSeriesDetail);
      when(() => mockTvSeasonBloc.state)
          .thenReturn(ListTvSeasonLoaded(tvSeasons: tTvSeasonList));
      final safeAreaFinder = find.byKey(Key('content_tvs'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(safeAreaFinder, findsOneWidget);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      initalizeStub();

      when(() => mockTvSeasonBloc.state)
          .thenReturn(ListTvSeasonError(message: 'Error'));

      final textFinder = find.byKey(Key('error_tvs'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });
}
