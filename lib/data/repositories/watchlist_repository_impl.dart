import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/data/models/watchlist_tabel.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

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
      return Left(UnknownFailure(e.toString()));
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
      return Left(UnknownFailure(e.toString()));
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
      return Left(UnknownFailure(e.toString()));
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
      return Left(UnknownFailure(e.toString()));
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
      return Left(UnknownFailure(e.toString()));
    }
  }
}
