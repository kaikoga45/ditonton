import 'package:bloc_test/bloc_test.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:top_rated_tv_series/top_rated_tv_series.dart';

class MockTopRatedTvSeriesBloc
    extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class TopRatedTvSeriesEventFake extends TopRatedTvSeriesEvent {}

class TopRatedTvSeriesStateFake extends TopRatedTvSeriesState {}

void main() {
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvSeriesEventFake());
    registerFallbackValue(TopRatedTvSeriesStateFake());
  });

  setUp(() {
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        BlocProvider<TopRatedTvSeriesBloc>(
            create: (context) => mockTopRatedTvSeriesBloc),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  final tTvSeriesList = testTvSeriesList;

  group('Tv Series Top Rated List', () {
    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockTopRatedTvSeriesBloc.add(FetchTopRatedTvSeries()))
          .thenReturn([]);
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(TopRatedTvSeriesLoading());
      final centerFinder = find.byKey(Key('center_trts'));
      final pogressFinder = find.byKey(Key('progress_trts'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockTopRatedTvSeriesBloc.add(FetchTopRatedTvSeries()))
          .thenReturn([]);
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(TopRatedTvSeriesLoaded(tvSeries: tTvSeriesList));
      final contentFinder = find.byKey(Key('trts'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockTopRatedTvSeriesBloc.add(FetchTopRatedTvSeries()))
          .thenReturn([]);
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(TopRatedTvSeriesError(message: 'error'));

      final textFinder = find.byKey(Key('error_trts'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
