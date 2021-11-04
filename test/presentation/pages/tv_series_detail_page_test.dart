import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tId = 90462;

  group('Detail Content', () {
    void _makeTestableStubDetailContent({
      required RequestState recommendationState,
      required List<TvSeries> tvSeriesRecommendations,
    }) {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.recommendationState).thenReturn(recommendationState);
      when(mockNotifier.recommendation).thenReturn(tvSeriesRecommendations);
      when(mockNotifier.tvSeasonState).thenReturn(RequestState.Loading);
    }

    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display detail tv series when data is loaded',
        (WidgetTester tester) async {
      _makeTestableStubDetailContent(
        recommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
      );

      final detailContentFinder = find.byType(DetailContent);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(detailContentFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });
  });
}
