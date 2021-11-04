import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class GetWatchListStatus {
  final WatchlistRepository repository;

  GetWatchListStatus({required this.repository});

  Future<Either<Failure, bool>> execute(int id, WatchlistType type) async {
    return repository.isAddedToWatchlist(id, type);
  }
}
