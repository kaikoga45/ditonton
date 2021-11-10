import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:search/search.dart';

class MockSearchMoviesBloc
    extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}

class SearchMoviesEventFake extends SearchMoviesEvent {}

class SearchMoviesStateFake extends SearchMoviesState {}

class MockSearchTvSeriesBloc
    extends MockBloc<SearchTvSeriesEvent, SearchTvSeriesState>
    implements SearchTvSeriesBloc {}

class SearchTvSeriesEventFake extends SearchTvSeriesEvent {}

class SearchTvSeriesStateFake extends SearchTvSeriesState {}

void main() {
  late MockSearchMoviesBloc mockSearchMoviesBloc;
  late MockSearchTvSeriesBloc mockSearchTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(SearchMoviesEventFake());
    registerFallbackValue(SearchMoviesStateFake());
    registerFallbackValue(SearchTvSeriesEventFake());
    registerFallbackValue(SearchTvSeriesStateFake());
  });

  setUp(() {
    mockSearchMoviesBloc = MockSearchMoviesBloc();
    mockSearchTvSeriesBloc = MockSearchTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<SearchMoviesBloc>(
            create: (context) => mockSearchMoviesBloc),
        BlocProvider<SearchTvSeriesBloc>(
            create: (context) => mockSearchTvSeriesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tMovieQuery = 'spiderman';
  final tMovieList = testMovieList;
  final tTvSeriesQuery = 'chucky';
  final tTvSeriesList = testTvSeriesList;

  group('Search Movies', () {
    void makeStub() {
      when(() => mockSearchTvSeriesBloc.state)
          .thenReturn(SearchTvSeriesLoading());
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      makeStub();
      when(() =>
              mockSearchMoviesBloc.add(FetchedSearchMovies(query: tMovieQuery)))
          .thenReturn([]);
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchMoviesLoading());
      final centerFinder = find.byKey(Key('center_sm'));
      final pogressFinder = find.byKey(Key('progress_sm'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      makeStub();

      when(() =>
              mockSearchMoviesBloc.add(FetchedSearchMovies(query: tMovieQuery)))
          .thenReturn(tMovieList);
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(SearchMoviesLoaded(movies: tMovieList));
      final contentFinder = find.byKey(Key('sm'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      makeStub();

      when(() =>
              mockSearchMoviesBloc.add(FetchedSearchMovies(query: tMovieQuery)))
          .thenReturn([]);
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(SearchMoviesError(message: 'error'));
      final textFinder = find.byKey(Key('error_sm'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Search Tv Series', () {
    void makeStub() {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchMoviesLoading());
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      makeStub();
      when(() => mockSearchTvSeriesBloc
          .add(FetchedSearchTvSeries(query: tTvSeriesQuery))).thenReturn([]);
      when(() => mockSearchTvSeriesBloc.state)
          .thenReturn(SearchTvSeriesLoading());
      final centerFinder = find.byKey(Key('center_stv'));
      final pogressFinder = find.byKey(Key('progress_stv'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      makeStub();

      when(() => mockSearchTvSeriesBloc.add(
          FetchedSearchTvSeries(query: tTvSeriesQuery))).thenReturn(tMovieList);
      when(() => mockSearchTvSeriesBloc.state)
          .thenReturn(SearchTvSeriesLoaded(tvSeries: tTvSeriesList));
      final contentFinder = find.byKey(Key('stv'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      makeStub();

      when(() => mockSearchTvSeriesBloc
          .add(FetchedSearchTvSeries(query: tTvSeriesQuery))).thenReturn([]);
      when(() => mockSearchTvSeriesBloc.state)
          .thenReturn(SearchTvSeriesError(message: 'error'));
      final textFinder = find.byKey(Key('error_stv'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
