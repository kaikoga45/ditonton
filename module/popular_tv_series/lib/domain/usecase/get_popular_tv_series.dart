import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetPopularTvSeries {
  TvSeriesRepository repository;

  GetPopularTvSeries({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute() async {
    return repository.getPopularTvSeries();
  }
}
