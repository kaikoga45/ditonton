import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
