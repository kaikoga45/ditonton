import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvSeriesWatchListStatus {
  final WatchlistRepository repository;

  GetTvSeriesWatchListStatus({required this.repository});

  Future<Either<Failure, bool>> execute(int id, WatchlistType type) async {
    return repository.isAddedToWatchlist(id, type);
  }
}
