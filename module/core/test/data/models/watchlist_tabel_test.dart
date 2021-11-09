import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tWatchlistMovie = testWatchlistMovie;
  final tWatclistMovieTabel = testWatchlistMovieTabel;
  final tMovieTable = testMovieTable;

  final tTvSeriesTable = testTvSeriesTable;
  final tWatchlistTvSeriesTabel = testWatchlistTvSeriesTabel;

  test(
      'should return a Watchlist entity when convert from watchlist table model',
      () {
    final result = tWatclistMovieTabel.toEntity();
    expect(result, tWatchlistMovie);
  });

  test(
      'should be a subclass Movie Watchlist Table model when convert from movie table model',
      () {
    final result = WatchlistTabel.movie(tMovieTable);
    expect(result, tWatclistMovieTabel);
  });

  test(
      'should be a subclass Tv Series Watchlist Table model when convert from tv series table model',
      () {
    final result = WatchlistTabel.tvSeries(tTvSeriesTable);
    expect(result, tWatchlistTvSeriesTabel);
  });
}
