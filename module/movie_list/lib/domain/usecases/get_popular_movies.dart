import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetListPopularMovies {
  final MovieRepository repository;

  GetListPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
