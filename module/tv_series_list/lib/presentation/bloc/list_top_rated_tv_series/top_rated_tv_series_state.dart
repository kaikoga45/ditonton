part of 'top_rated_tv_series_bloc.dart';

abstract class ListTopRatedTvSeriesState extends Equatable {
  const ListTopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesEmpty extends ListTopRatedTvSeriesState {}

class TopRatedTvSeriesLoading extends ListTopRatedTvSeriesState {}

class TopRatedTvSeriesLoaded extends ListTopRatedTvSeriesState {
  final List<TvSeries> tvSeries;

  const TopRatedTvSeriesLoaded({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class TopRatedTvSeriesError extends ListTopRatedTvSeriesState {
  final String message;

  const TopRatedTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
