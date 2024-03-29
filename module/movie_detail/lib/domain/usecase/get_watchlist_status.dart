import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetMovieWatchListStatus {
  final WatchlistRepository repository;

  GetMovieWatchListStatus({required this.repository});

  Future<Either<Failure, bool>> execute(int id, WatchlistType type) async {
    return repository.isAddedToWatchlist(id, type);
  }
}
