part of 'list_now_playing_movies_bloc.dart';

abstract class ListNowPlayingMoviesEvent extends Equatable {
  const ListNowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchListNowPlayingMovies extends ListNowPlayingMoviesEvent {}
