import 'package:bloc_test/bloc_test.dart';
import 'package:core/dummy_data/dummy_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popular_tv_series/popular_tv_series.dart';
import 'package:provider/provider.dart';

class MockPopularTvSeriesBloc
    extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class PopularTvSeriesEventFake extends PopularTvSeriesEvent {}

class PopularTvSeriesStateFake extends PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvSeriesEventFake());
    registerFallbackValue(PopularTvSeriesStateFake());
  });

  setUp(() {
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<PopularTvSeriesBloc>(
            create: (context) => mockPopularTvSeriesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tTvSeriesList = testTvSeriesList;

  group('TvSeries Popular', () {
    testWidgets('should display loading ui', (WidgetTester tester) async {
      when(() => mockPopularTvSeriesBloc.add(FetchPopularTvSeries()))
          .thenReturn([]);
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(PopularTvSeriesLoading());
      final centerFinder = find.byKey(Key('center_ptvs'));
      final pogressFinder = find.byKey(Key('progress_ptvs'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(pogressFinder, findsOneWidget);
    });

    testWidgets('should display loaded ui', (WidgetTester tester) async {
      when(() => mockPopularTvSeriesBloc.add(FetchPopularTvSeries()))
          .thenReturn(tTvSeriesList);
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(PopularTvSeriesLoaded(tvSeries: tTvSeriesList));
      final contentFinder = find.byKey(Key('ptvs'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

      expect(contentFinder, findsWidgets);
    });

    testWidgets('should display error ui', (WidgetTester tester) async {
      when(() => mockPopularTvSeriesBloc.add(FetchPopularTvSeries()))
          .thenReturn([]);
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(PopularTvSeriesError(message: 'error'));
      final textFinder = find.byKey(Key('error_ptvs'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
