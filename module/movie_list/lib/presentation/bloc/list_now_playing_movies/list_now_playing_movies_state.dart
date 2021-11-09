part of 'list_now_playing_movies_bloc.dart';

abstract class ListNowPlayingMoviesState extends Equatable {
  const ListNowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends ListNowPlayingMoviesState {}

class NowPlayingMoviesLoading extends ListNowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends ListNowPlayingMoviesState {
  final List<Movie> movies;

  NowPlayingMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class NowPlayingMoviesError extends ListNowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
