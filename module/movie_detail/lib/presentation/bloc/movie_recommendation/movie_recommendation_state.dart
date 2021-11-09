part of 'movie_recommendation_bloc.dart';

@immutable
abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movies;

  MovieRecommendationLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  MovieRecommendationError({required this.message});

  @override
  List<Object> get props => [message];
}
