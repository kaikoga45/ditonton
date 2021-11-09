import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetListTopRatedMovies {
  final MovieRepository repository;

  GetListTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
