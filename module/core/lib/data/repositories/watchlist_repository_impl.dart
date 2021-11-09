import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class WatchlistRepositoryImpl extends WatchlistRepository {
  MovieLocalDataSource movieLocalDataSource;
  TvSeriesLocalDataSource tvSeriesLocalDataSource;

  WatchlistRepositoryImpl({
    required this.movieLocalDataSource,
    required this.tvSeriesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlist() async {
    try {
      final movieResult = await movieLocalDataSource.getWatchlistMovies();
      final watchlistMovie = movieResult
          .map((movie) => WatchlistTabel.movie(movie).toEntity())
          .toList();
      final tvSeriesResult =
          await tvSeriesLocalDataSource.getWatchlistTvSeries();
      final watchlistTvSeries = tvSeriesResult
          .map((tvSeries) => WatchlistTabel.tvSeries(tvSeries).toEntity())
          .toList();
      final watchlist = [...watchlistMovie, ...watchlistTvSeries];
      return Right(watchlist);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAddedToWatchlist(
      int id, WatchlistType type) async {
    try {
      late var result;
      if (type == WatchlistType.Movie) {
        result = await movieLocalDataSource.getMovieById(id);
      } else {
        result = await tvSeriesLocalDataSource.getTvSeriesById(id);
      }
      return Right(result != null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistMovies(MovieDetail movie) async {
    try {
      final result = await movieLocalDataSource
          .insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistMovies(
      MovieDetail movie) async {
    try {
      final result = await movieLocalDataSource
          .removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail tvSeries) async {
    try {
      final result = await tvSeriesLocalDataSource
          .removeWatchlist(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail tvSeries) async {
    try {
      final result = await tvSeriesLocalDataSource
          .insertWatchlist(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
