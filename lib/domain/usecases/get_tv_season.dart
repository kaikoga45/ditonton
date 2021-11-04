import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeason {
  final TvSeriesRepository repository;

  GetTvSeason({required this.repository});

  Future<Either<Failure, List<TvSeason>>> execute(int id, int totalSeason) {
    return repository.getTvSeason(id, totalSeason);
  }
}
