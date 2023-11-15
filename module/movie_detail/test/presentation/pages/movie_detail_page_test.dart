import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MovieWatchlistEventFake extends Fake implements MovieWatchlistEvent {}

class MovieWatchlistStateFake extends Fake implements MovieWatchlistState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MovieRecommendationEventFake extends Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake
    implements MovieRecommendationState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
    registerFallbackValue(MovieRecommendationEventFake());
    registerFallbackValue(MovieRecommendationStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => mockMovieRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tId = 1;
  final tMovieDetail = testMovieDetail;
  final tMovieList = testMovieList;

  group('Movie Detail Bloc', () {
    void _makeStubBloc() {
      when(() => mockMovieWatchlistBloc.add(any())).thenReturn(null);
      when(() => mockMovieRecommendationBloc.add(any())).thenReturn(null);
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistLoading());
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoading());
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.add(FetchMovieDetail(id: tId)))
          .thenReturn([]);
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
      final centerFinder = find.byType(Center);
      final circularFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(circularFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.add(FetchMovieDetail(id: tId)))
          .thenReturn(tMovieDetail);
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(movie: tMovieDetail));
      _makeStubBloc();

      final safeAreaFinder = find.byType(SafeArea);
      final detailContentFinder = find.byType(DetailContent);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(safeAreaFinder, findsOneWidget);
      expect(detailContentFinder, findsOneWidget);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailError(message: 'Error'));

      final textFinder = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Movie Recommendation Bloc', () {
    void _makeStubBloc() {
      when(() => mockMovieDetailBloc.add(FetchMovieDetail(id: tId)))
          .thenReturn(tMovieDetail);
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(movie: tMovieDetail));
      when(() => mockMovieWatchlistBloc.add(any())).thenReturn(null);
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistLoading());
    }

    testWidgets('should display loading ui', (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoading());
      final centerFinder = find.byKey(Key('center_mr'));
      final circularFinder = find.byKey(Key('cpi_mr'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(circularFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieRecommendationBloc.add(
          FetchMovieRecommendation(movieId: tId))).thenReturn(tMovieDetail);
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(movies: tMovieList));
      final recommendationContentFinder = find.byKey(Key('content_mr'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(recommendationContentFinder, findsOneWidget);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationError(message: 'Error'));

      final textFinder = find.byKey(Key('text_mr'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Movie Watchlist Bloc', () {
    void _makeStubBloc() {
      when(() => mockMovieDetailBloc.add(FetchMovieDetail(id: tId)))
          .thenReturn(tMovieDetail);
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(movie: tMovieDetail));
      when(() => mockMovieRecommendationBloc.add(any())).thenReturn(null);
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoading());
    }

    testWidgets('should display loading ui when being load watchlist status',
        (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieWatchlistBloc.add(LoadWatchlistStatus(
            movieId: tId,
            watchlistType: WatchlistType.Movie,
          ))).thenReturn(MovieWatchlistLoading());
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistLoading());
      final centerFinder = find.byKey(Key('center_mw'));
      final circularFinder = find.byKey(Key('cpi_mw'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(circularFinder, findsOneWidget);
    });

    testWidgets(
        'should display check watchlist button when watchlist status equal true',
        (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieWatchlistBloc
              .add(AddMovieWatchlist(movieDetail: tMovieDetail)))
          .thenReturn(tMovieDetail);
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistLoaded(watchlistStatus: true));
      final watchlistButtonFinder = find.byKey(Key('watchlist_button_mw'));
      final checkFinder = find.byKey(Key('check_mw'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(watchlistButtonFinder, findsOneWidget);
      expect(checkFinder, findsOneWidget);
    });

    testWidgets(
        'should display add watchlist button when watchlist status equal false',
        (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieWatchlistBloc.add(RemoveMovieWatchlist(
            movieDetail: tMovieDetail,
            watchlistType: WatchlistType.Movie,
          ))).thenReturn(tMovieDetail);
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistLoaded(watchlistStatus: false));
      final watchlistButtonFinder = find.byKey(Key('watchlist_button_mw'));
      final addFinder = find.byKey(Key('add_mw'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(watchlistButtonFinder, findsOneWidget);
      expect(addFinder, findsOneWidget);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      _makeStubBloc();
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistError(message: 'Error'));

      final textFinder = find.byKey(Key('error_mw'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });
}
