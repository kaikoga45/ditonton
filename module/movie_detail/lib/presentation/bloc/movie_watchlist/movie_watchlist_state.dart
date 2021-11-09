part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final bool watchlistStatus;

  MovieWatchlistLoaded({required this.watchlistStatus});

  @override
  List<Object> get props => [watchlistStatus];
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}
