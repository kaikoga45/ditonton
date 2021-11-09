part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchMoviesEmpty extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> movies;

  const SearchMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  const SearchMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
