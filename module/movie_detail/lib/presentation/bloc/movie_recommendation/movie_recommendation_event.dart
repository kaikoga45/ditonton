part of 'movie_recommendation_bloc.dart';

@immutable
abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends MovieRecommendationEvent {
  final int movieId;

  FetchMovieRecommendation({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
