import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class SaveWatchlistMovie {
  final WatchlistRepository repository;

  SaveWatchlistMovie({required this.repository});

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlistMovies(movie);
  }
}
