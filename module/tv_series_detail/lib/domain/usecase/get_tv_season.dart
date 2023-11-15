import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvSeason {
  final TvSeriesRepository repository;

  GetTvSeason({required this.repository});

  Future<Either<Failure, List<TvSeason>>> execute(int id, int totalSeason) {
    return repository.getTvSeason(id, totalSeason);
  }
}
