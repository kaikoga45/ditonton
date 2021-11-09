part of 'list_top_rated_movies_bloc.dart';

abstract class ListTopRatedMoviesState extends Equatable {
  const ListTopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends ListTopRatedMoviesState {}

class TopRatedMoviesLoading extends ListTopRatedMoviesState {}

class TopRatedMoviesLoaded extends ListTopRatedMoviesState {
  final List<Movie> movies;

  TopRatedMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class TopRatedMoviesError extends ListTopRatedMoviesState {
  final String message;

  TopRatedMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
