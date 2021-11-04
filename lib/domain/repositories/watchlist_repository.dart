import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

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
