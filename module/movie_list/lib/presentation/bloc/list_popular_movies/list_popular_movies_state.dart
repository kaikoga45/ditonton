part of 'list_popular_movies_bloc.dart';

abstract class ListPopularMoviesState extends Equatable {
  const ListPopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesEmpty extends ListPopularMoviesState {}

class PopularMoviesLoading extends ListPopularMoviesState {}

class PopularMoviesLoaded extends ListPopularMoviesState {
  final List<Movie> movies;

  PopularMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class PopularMoviesError extends ListPopularMoviesState {
  final String message;

  PopularMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
