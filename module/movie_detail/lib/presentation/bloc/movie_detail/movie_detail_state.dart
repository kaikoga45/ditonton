part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailLoaded({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
