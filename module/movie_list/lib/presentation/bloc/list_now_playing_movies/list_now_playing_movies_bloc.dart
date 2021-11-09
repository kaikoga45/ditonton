import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_list/domain/usecases/get_now_playing_movies.dart';

part 'list_now_playing_movies_event.dart';
part 'list_now_playing_movies_state.dart';

class ListNowPlayingMoviesBloc
    extends Bloc<ListNowPlayingMoviesEvent, ListNowPlayingMoviesState> {
  final GetListNowPlayingMovies getNowPlayingMovies;

  ListNowPlayingMoviesBloc({required this.getNowPlayingMovies})
      : super(NowPlayingMoviesEmpty());

  @override
  Stream<ListNowPlayingMoviesState> mapEventToState(
      ListNowPlayingMoviesEvent event) async* {
    yield NowPlayingMoviesLoading();
    final result = await getNowPlayingMovies.execute();
    yield* result.fold(
      (failure) async* {
        yield NowPlayingMoviesError(message: failure.message);
      },
      (result) async* {
        yield NowPlayingMoviesLoaded(movies: result);
      },
    );
  }
}
