import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
