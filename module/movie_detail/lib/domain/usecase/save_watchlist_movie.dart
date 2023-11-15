import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SaveWatchlistMovie {
  final WatchlistRepository repository;

  SaveWatchlistMovie({required this.repository});

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlistMovies(movie);
  }
}
