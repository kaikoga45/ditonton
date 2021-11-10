import 'package:bloc_test/bloc_test.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_list/tv_series_list.dart';

class MockListTvOnAirBloc extends MockBloc<ListTvOnAirEvent, ListTvOnAirState>
    implements ListTvOnAirBloc {}

class ListNowPlayingMoviesEventFake extends ListTvOnAirEvent {}

class ListNowPlayingMoviesStateFake extends ListTvOnAirState {}

class MockListPopularTvSeriesBloc
    extends MockBloc<ListPopularTvSeriesEvent, ListPopularTvSeriesState>
    implements ListPopularTvSeriesBloc {}

class ListPopularMoviesEventFake extends ListPopularTvSeriesEvent {}

class ListPopularMoviesStateFake extends ListPopularTvSeriesState {}

class MockListTopRatedTvSeriesBloc
    extends MockBloc<ListTopRatedTvSeriesEvent, ListTopRatedTvSeriesState>
    implements ListTopRatedTvSeriesBloc {}

class ListTopRatedMoviesEventFake extends ListTopRatedTvSeriesEvent {}

class ListTopRatedMoviesStateFake extends ListTopRatedTvSeriesState {}

void main() {
  late MockListTvOnAirBloc mockListTvOnAirBloc;
  late MockListPopularTvSeriesBloc mockListPopularTvSeriesBloc;
  late MockListTopRatedTvSeriesBloc mockListTopRatedTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(ListNowPlayingMoviesEventFake());
    registerFallbackValue(ListNowPlayingMoviesStateFake());
    registerFallbackValue(ListPopularMoviesEventFake());
    registerFallbackValue(ListPopularMoviesStateFake());
    registerFallbackValue(ListTopRatedMoviesEventFake());
    registerFallbackValue(ListTopRatedMoviesStateFake());
  });

  setUp(() {
    mockListTvOnAirBloc = MockListTvOnAirBloc();
    mockListPopularTvSeriesBloc = MockListPopularTvSeriesBloc();
    mockListTopRatedTvSeriesBloc = MockListTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        BlocProvider<ListTvOnAirBloc>(create: (context) => mockListTvOnAirBloc),
        BlocProvider<ListPopularTvSeriesBloc>(
            create: (context) => mockListPopularTvSeriesBloc),
        BlocProvider<ListTopRatedTvSeriesBloc>(
            create: (context) => mockListTopRatedTvSeriesBloc),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  void _stubStateBloc(
      ListTvOnAirState tvOnAirState,
      ListPopularTvSeriesState popularTvSeriesState,
      ListTopRatedTvSeriesState topRatedTvSeriesState) {
    when(() => mockListTvOnAirBloc.state).thenReturn(tvOnAirState);
    when(() => mockListPopularTvSeriesBloc.state)
        .thenReturn(popularTvSeriesState);
    when(() => mockListTopRatedTvSeriesBloc.state)
        .thenReturn(topRatedTvSeriesState);
  }

  final tTvSeriesList = testTvSeriesList;

  group('Tv On Air List', () {
    void _stubEventBloc() {
      when(() => mockListPopularTvSeriesBloc.add(any())).thenReturn(null);
      when(() => mockListTopRatedTvSeriesBloc.add(any())).thenReturn(null);
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockListTvOnAirBloc.add(FetchTvOnAir())).thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoading(), PopularTvSeriesLoading(),
          TopRatedTvSeriesLoading());
      final centerFinder = find.byKey(Key('center_tva'));
      final pogressFinder = find.byKey(Key('progress_tva'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockListTvOnAirBloc.add(FetchTvOnAir()))
          .thenReturn(tTvSeriesList);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoaded(tvOnAir: tTvSeriesList),
          PopularTvSeriesLoading(), TopRatedTvSeriesLoading());
      final contentFinder = find.byKey(Key('tva'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockListTvOnAirBloc.add(FetchTvOnAir())).thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(TvOnAirError(message: 'error'), PopularTvSeriesLoading(),
          TopRatedTvSeriesLoading());
      final textFinder = find.byKey(Key('error_tva'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Tv Series Popular List', () {
    void _stubEventBloc() {
      when(() => mockListTvOnAirBloc.add(any())).thenReturn(null);
      when(() => mockListTopRatedTvSeriesBloc.add(any())).thenReturn(null);
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockListPopularTvSeriesBloc.add(FetchListPopularTvSeries()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoading(), PopularTvSeriesLoading(),
          TopRatedTvSeriesLoading());
      final centerFinder = find.byKey(Key('center_pts'));
      final pogressFinder = find.byKey(Key('progress_pts'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockListPopularTvSeriesBloc.add(FetchListPopularTvSeries()))
          .thenReturn(tTvSeriesList);
      _stubEventBloc();
      _stubStateBloc(
          TvOnAirLoading(),
          PopularTvSeriesLoaded(tvSeries: tTvSeriesList),
          TopRatedTvSeriesLoading());
      final contentFinder = find.byKey(Key('pts'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockListPopularTvSeriesBloc.add(FetchListPopularTvSeries()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoading(), PopularTvSeriesError(message: 'error'),
          TopRatedTvSeriesLoading());
      final textFinder = find.byKey(Key('error_pts'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Tv Series Top Rated List', () {
    void _stubEventBloc() {
      when(() => mockListTvOnAirBloc.add(any())).thenReturn(null);
      when(() => mockListPopularTvSeriesBloc.add(FetchListPopularTvSeries()))
          .thenReturn([]);
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockListTopRatedTvSeriesBloc.add(FetchListTopRatedTvSeries()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoading(), PopularTvSeriesLoading(),
          TopRatedTvSeriesLoading());
      final centerFinder = find.byKey(Key('center_trts'));
      final pogressFinder = find.byKey(Key('progress_trts'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockListTopRatedTvSeriesBloc.add(FetchListTopRatedTvSeries()))
          .thenReturn(tTvSeriesList);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoading(), PopularTvSeriesLoading(),
          TopRatedTvSeriesLoaded(tvSeries: tTvSeriesList));
      final contentFinder = find.byKey(Key('trts'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockListTopRatedTvSeriesBloc.add(FetchListTopRatedTvSeries()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(TvOnAirLoading(), PopularTvSeriesLoading(),
          TopRatedTvSeriesError(message: 'error'));
      final textFinder = find.byKey(Key('error_trts'));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
