import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_detail/movie_detail.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetMovieWatchListStatus getWatchListStatus;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;

  MovieWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
  }) : super(MovieWatchlistEmpty());

  @override
  Stream<MovieWatchlistState> mapEventToState(
      MovieWatchlistEvent event) async* {
    if (event is LoadWatchlistStatus) {
      yield MovieWatchlistLoading();
      final result =
          await getWatchListStatus.execute(event.movieId, event.watchlistType);
      yield* result.fold(
        (failure) async* {
          yield MovieWatchlistError(message: failure.message);
        },
        (result) async* {
          yield MovieWatchlistLoaded(watchlistStatus: result);
        },
      );
    } else if (event is AddMovieWatchlist) {
      yield MovieWatchlistLoading();
      final result = await saveWatchlistMovie.execute(event.movieDetail);
      yield* result.fold(
        (failure) async* {
          yield MovieWatchlistError(message: failure.message);
        },
        (result) async* {
          yield MovieWatchlistLoaded(watchlistStatus: true);
        },
      );
    } else if (event is RemoveMovieWatchlist) {
      yield MovieWatchlistLoading();
      final result = await removeWatchlistMovie.execute(event.movieDetail);
      yield* result.fold(
        (failure) async* {
          yield MovieWatchlistError(message: failure.message);
        },
        (result) async* {
          yield MovieWatchlistLoaded(watchlistStatus: false);
        },
      );
    }
  }
}
