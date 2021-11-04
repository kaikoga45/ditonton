import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class SaveWatchlistTvSeries {
  final WatchlistRepository repository;

  SaveWatchlistTvSeries({required this.repository});

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlistTvSeries(tvSeries);
  }
}
