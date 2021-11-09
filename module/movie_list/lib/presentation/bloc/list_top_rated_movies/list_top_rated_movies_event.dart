part of 'list_top_rated_movies_bloc.dart';

abstract class ListTopRatedMoviesEvent extends Equatable {
  const ListTopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchListTopRatedMovies extends ListTopRatedMoviesEvent {}
