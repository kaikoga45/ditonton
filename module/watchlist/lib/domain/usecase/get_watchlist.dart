import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetWatchlist {
  final WatchlistRepository repository;

  GetWatchlist({required this.repository});

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlist();
  }
}
