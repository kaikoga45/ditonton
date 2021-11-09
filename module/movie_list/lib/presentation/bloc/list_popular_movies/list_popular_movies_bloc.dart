import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';
import 'package:movie_list/domain/usecases/get_popular_movies.dart';

part 'list_popular_movies_event.dart';
part 'list_popular_movies_state.dart';

class ListPopularMoviesBloc
    extends Bloc<ListPopularMoviesEvent, ListPopularMoviesState> {
  final GetListPopularMovies getPopularMovies;

  ListPopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesEmpty());

  @override
  Stream<ListPopularMoviesState> mapEventToState(
    ListPopularMoviesEvent event,
  ) async* {
    if (event is FetchListPopularMovies) {
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
