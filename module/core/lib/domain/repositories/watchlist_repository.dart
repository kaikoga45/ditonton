import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Watchlist>>> getWatchlist();
  Future<Either<Failure, bool>> isAddedToWatchlist(int id, WatchlistType type);
  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> saveWatchlistMovies(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlistMovies(MovieDetail movie);
}
