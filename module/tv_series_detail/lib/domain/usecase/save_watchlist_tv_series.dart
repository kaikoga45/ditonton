import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SaveWatchlistTvSeries {
  final WatchlistRepository repository;

  SaveWatchlistTvSeries({required this.repository});

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlistTvSeries(tvSeries);
  }
}
