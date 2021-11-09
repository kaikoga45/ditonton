import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeason>>> getTvSeason(int id, int totalSeason);
  Future<Either<Failure, List<TvSeries>>> getTvOnAir();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
}
