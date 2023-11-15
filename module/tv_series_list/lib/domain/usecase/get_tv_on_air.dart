import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvOnAir {
  final TvSeriesRepository repository;

  GetTvOnAir({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvOnAir();
  }
}
