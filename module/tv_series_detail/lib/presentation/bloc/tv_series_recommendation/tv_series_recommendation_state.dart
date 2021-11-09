part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationEmpty extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoaded extends TvSeriesRecommendationState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationLoaded({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationError({required this.message});

  @override
  List<Object> get props => [message];
}
