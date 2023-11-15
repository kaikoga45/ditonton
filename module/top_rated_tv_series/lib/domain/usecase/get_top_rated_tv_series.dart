import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTvSeries {
  TvSeriesRepository repository;

  GetTopRatedTvSeries({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute() async {
    return await repository.getTopRatedTvSeries();
  }
}
