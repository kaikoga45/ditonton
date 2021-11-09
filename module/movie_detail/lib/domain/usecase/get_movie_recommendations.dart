import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
