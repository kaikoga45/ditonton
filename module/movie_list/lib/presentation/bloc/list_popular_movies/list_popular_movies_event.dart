part of 'list_popular_movies_bloc.dart';

abstract class ListPopularMoviesEvent extends Equatable {
  const ListPopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchListPopularMovies extends ListPopularMoviesEvent {}
