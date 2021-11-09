part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends MovieWatchlistEvent {
  final int movieId;
  final WatchlistType watchlistType;

  LoadWatchlistStatus({required this.movieId, required this.watchlistType});

  @override
  List<Object> get props => [movieId, watchlistType];
}

class AddMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  AddMovieWatchlist({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;
  final WatchlistType watchlistType;

  RemoveMovieWatchlist(
      {required this.movieDetail, required this.watchlistType});

  @override
  List<Object> get props => [movieDetail, watchlistType];
}
