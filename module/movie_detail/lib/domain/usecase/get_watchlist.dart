import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetMovieWatchlist {
  final WatchlistRepository repository;

  GetMovieWatchlist({required this.repository});

  Future<Either<Failure, List<Watchlist>>> execute() {
    return repository.getWatchlist();
  }
}
