import 'package:bloc_test/bloc_test.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:top_rated_movies/top_rated_movies.dart';

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class TopRatedMoviesEventFake extends TopRatedMoviesEvent {}

class TopRatedMoviesStateFake extends TopRatedMoviesState {}

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMoviesEventFake());
    registerFallbackValue(TopRatedMoviesStateFake());
  });

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        BlocProvider<TopRatedMoviesBloc>(
            create: (context) => mockTopRatedMoviesBloc),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  final tMovieList = testMovieList;

  group('Movie Top Rated', () {
    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.add(FetchTopRatedMovies()))
          .thenReturn([]);
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesLoading());
      final centerFinder = find.byKey(Key('center_trm'));
      final pogressFinder = find.byKey(Key('progress_trm'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.add(FetchTopRatedMovies()))
          .thenReturn(tMovieList);
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesLoaded(movies: tMovieList));
      final contentFinder = find.byKey(Key('trm'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.add(FetchTopRatedMovies()))
          .thenReturn([]);
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesError(message: 'error'));
      final textFinder = find.byKey(Key('error_trm'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
      expect(textFinder, findsOneWidget);
    });
  });
}
