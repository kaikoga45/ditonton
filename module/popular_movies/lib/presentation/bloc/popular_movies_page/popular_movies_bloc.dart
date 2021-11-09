import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:popular_movies/popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesEmpty());

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is FetchPopularMovies) {
      yield PopularMoviesLoading();
      final result = await getPopularMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield PopularMoviesError(message: failure.message);
        },
        (result) async* {
          yield PopularMoviesLoaded(movies: result);
        },
      );
    }
  }
}
