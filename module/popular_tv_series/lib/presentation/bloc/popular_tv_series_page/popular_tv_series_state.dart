part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesEmpty extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {}

class PopularTvSeriesLoaded extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  PopularTvSeriesLoaded({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
