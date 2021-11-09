import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';
import 'package:movie_list/domain/usecases/get_top_rated_movies.dart';

part 'list_top_rated_movies_event.dart';
part 'list_top_rated_movies_state.dart';

class ListTopRatedMoviesBloc
    extends Bloc<ListTopRatedMoviesEvent, ListTopRatedMoviesState> {
  final GetListTopRatedMovies getTopRatedMovies;

  ListTopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesEmpty());

  @override
  Stream<ListTopRatedMoviesState> mapEventToState(
      ListTopRatedMoviesEvent event) async* {
    if (event is FetchListTopRatedMovies) {
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
