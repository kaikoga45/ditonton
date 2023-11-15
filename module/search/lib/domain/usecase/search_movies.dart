import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies({required this.repository});

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
