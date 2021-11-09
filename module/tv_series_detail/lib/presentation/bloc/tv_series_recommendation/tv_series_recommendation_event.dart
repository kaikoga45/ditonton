part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationEvent extends Equatable {
  const TvSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesRecommendation extends TvSeriesRecommendationEvent {
  final int tvSeriesId;

  FetchTvSeriesRecommendation({required this.tvSeriesId});

  @override
  List<Object> get props => [tvSeriesId];
}
