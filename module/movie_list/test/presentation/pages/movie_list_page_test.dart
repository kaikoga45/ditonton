import 'package:bloc_test/bloc_test.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list/movie_list.dart';
import 'package:movie_list/presentation/bloc/list_now_playing_movies/list_now_playing_movies_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockListNowPlayingMoviesBloc
    extends MockBloc<ListNowPlayingMoviesEvent, ListNowPlayingMoviesState>
    implements ListNowPlayingMoviesBloc {}

class ListNowPlayingMoviesEventFake extends ListNowPlayingMoviesEvent {}

class ListNowPlayingMoviesStateFake extends ListNowPlayingMoviesState {}

class MockListPopularMoviesBloc
    extends MockBloc<ListPopularMoviesEvent, ListPopularMoviesState>
    implements ListPopularMoviesBloc {}

class ListPopularMoviesEventFake extends ListPopularMoviesEvent {}

class ListPopularMoviesStateFake extends ListPopularMoviesState {}

class MockListTopRatedMoviesBloc
    extends MockBloc<ListTopRatedMoviesEvent, ListTopRatedMoviesState>
    implements ListTopRatedMoviesBloc {}

class ListTopRatedMoviesEventFake extends ListTopRatedMoviesEvent {}

class ListTopRatedMoviesStateFake extends ListTopRatedMoviesState {}

void main() {
  late MockListNowPlayingMoviesBloc mockListNowPlayingMoviesBloc;
  late MockListPopularMoviesBloc mockListPopularMoviesBloc;
  late MockListTopRatedMoviesBloc mockListTopRatedMoviesBloc;

  setUpAll(() {
    registerFallbackValue(ListNowPlayingMoviesEventFake());
    registerFallbackValue(ListNowPlayingMoviesStateFake());
    registerFallbackValue(ListPopularMoviesEventFake());
    registerFallbackValue(ListPopularMoviesStateFake());
    registerFallbackValue(ListTopRatedMoviesEventFake());
    registerFallbackValue(ListTopRatedMoviesStateFake());
  });

  setUp(() {
    mockListNowPlayingMoviesBloc = MockListNowPlayingMoviesBloc();
    mockListPopularMoviesBloc = MockListPopularMoviesBloc();
    mockListTopRatedMoviesBloc = MockListTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        BlocProvider<ListNowPlayingMoviesBloc>(
            create: (context) => mockListNowPlayingMoviesBloc),
        BlocProvider<ListPopularMoviesBloc>(
            create: (context) => mockListPopularMoviesBloc),
        BlocProvider<ListTopRatedMoviesBloc>(
            create: (context) => mockListTopRatedMoviesBloc),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  void _stubStateBloc(
      ListNowPlayingMoviesState nowPlayingMoviesState,
      ListPopularMoviesState popularMoviesState,
      ListTopRatedMoviesState topRatedMoviesState) {
    when(() => mockListNowPlayingMoviesBloc.state)
        .thenReturn(nowPlayingMoviesState);
    when(() => mockListPopularMoviesBloc.state).thenReturn(popularMoviesState);
    when(() => mockListTopRatedMoviesBloc.state)
        .thenReturn(topRatedMoviesState);
  }

  final tMovieList = testMovieList;

  group('Movie Now Playing List', () {
    void _stubEventBloc() {
      when(() => mockListPopularMoviesBloc.add(any())).thenReturn(null);
      when(() => mockListTopRatedMoviesBloc.add(any())).thenReturn(null);
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockListNowPlayingMoviesBloc.add(FetchListNowPlayingMovies()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(), PopularMoviesLoading(),
          TopRatedMoviesLoading());

      final centerFinder = find.byKey(Key('center_npm'));
      final pogressFinder = find.byKey(Key('progress_npm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockListNowPlayingMoviesBloc.add(FetchListNowPlayingMovies()))
          .thenReturn(tMovieList);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoaded(movies: tMovieList),
          PopularMoviesLoading(), TopRatedMoviesLoading());

      final contentFinder = find.byKey(Key('npm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockListNowPlayingMoviesBloc.add(FetchListNowPlayingMovies()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesError(message: 'error'),
          PopularMoviesLoading(), TopRatedMoviesLoading());
      final textFinder = find.byKey(Key('error_npm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Movie Popular List', () {
    void _stubEventBloc() {
      when(() => mockListNowPlayingMoviesBloc.add(any())).thenReturn([]);
      when(() => mockListTopRatedMoviesBloc.add(any())).thenReturn(null);
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockListPopularMoviesBloc.add(FetchListPopularMovies()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(), PopularMoviesLoading(),
          TopRatedMoviesLoading());
      final centerFinder = find.byKey(Key('center_pm'));
      final pogressFinder = find.byKey(Key('progress_pm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockListPopularMoviesBloc.add(FetchListPopularMovies()))
          .thenReturn(tMovieList);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(),
          PopularMoviesLoaded(movies: tMovieList), TopRatedMoviesLoading());
      final contentFinder = find.byKey(Key('pm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockListPopularMoviesBloc.add(FetchListPopularMovies()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(),
          PopularMoviesError(message: 'error'), TopRatedMoviesLoading());
      final textFinder = find.byKey(Key('error_pm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Movie Top Rated List', () {
    void _stubEventBloc() {
      when(() => mockListNowPlayingMoviesBloc.add(any())).thenReturn(null);
      when(() => mockListPopularMoviesBloc.add(any())).thenReturn(null);
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockListTopRatedMoviesBloc.add(FetchListTopRatedMovies()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(), PopularMoviesLoading(),
          TopRatedMoviesLoading());
      final centerFinder = find.byKey(Key('center_trm'));
      final pogressFinder = find.byKey(Key('progress_trm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockListTopRatedMoviesBloc.add(FetchListTopRatedMovies()))
          .thenReturn(tMovieList);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(), PopularMoviesLoading(),
          TopRatedMoviesLoaded(movies: tMovieList));
      final contentFinder = find.byKey(Key('trm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockListTopRatedMoviesBloc.add(FetchListTopRatedMovies()))
          .thenReturn([]);
      _stubEventBloc();
      _stubStateBloc(NowPlayingMoviesLoading(), PopularMoviesLoading(),
          TopRatedMoviesError(message: 'error'));
      final textFinder = find.byKey(Key('error_trm'));

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
