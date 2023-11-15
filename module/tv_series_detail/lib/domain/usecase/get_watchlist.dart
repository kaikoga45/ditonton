import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvSeriesWatchlist {
  final WatchlistRepository repository;

  GetTvSeriesWatchlist({required this.repository});

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlist();
  }
}
