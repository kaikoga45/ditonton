import 'package:bloc_test/bloc_test.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popular_movies/popular_movies.dart';
import 'package:provider/provider.dart';

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class PopularMoviesEventFake extends PopularMoviesEvent {}

class PopularMoviesStateFake extends PopularMoviesState {}

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUpAll(() {
    registerFallbackValue(PopularMoviesEventFake());
    registerFallbackValue(PopularMoviesStateFake());
  });

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
            create: (context) => mockPopularMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tMovieList = testMovieList;

  group('Movie Popular List', () {
    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.add(FetchPopularMovies()))
          .thenReturn([]);
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesLoading());
      final centerFinder = find.byKey(Key('center_pm'));
      final pogressFinder = find.byKey(Key('progress_pm'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.add(FetchPopularMovies()))
          .thenReturn(tMovieList);
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesLoaded(movies: tMovieList));
      final contentFinder = find.byKey(Key('pm'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.add(FetchPopularMovies()))
          .thenReturn([]);
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesError(message: 'error'));
      final textFinder = find.byKey(Key('error_pm'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
