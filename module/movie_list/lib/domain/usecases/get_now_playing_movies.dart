import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetListNowPlayingMovies {
  final MovieRepository repository;

  GetListNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
