import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:top_rated_movies/top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesEmpty());

  @override
  Stream<TopRatedMoviesState> mapEventToState(
      TopRatedMoviesEvent event) async* {
    if (event is FetchTopRatedMovies) {
      yield TopRatedMoviesLoading();
      final result = await getTopRatedMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield TopRatedMoviesError(message: failure.message);
        },
        (movies) async* {
          yield TopRatedMoviesLoaded(movies: movies);
        },
      );
    }
  }
}
