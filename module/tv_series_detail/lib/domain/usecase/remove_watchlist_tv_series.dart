import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlistTvSerios {
  final WatchlistRepository repository;

  RemoveWatchlistTvSerios({required this.repository});

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlistTvSeries(tvSeries);
  }
}
