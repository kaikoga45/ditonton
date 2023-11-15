import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlistMovie {
  final WatchlistRepository repository;

  RemoveWatchlistMovie({required this.repository});

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlistMovies(movie);
  }
}
