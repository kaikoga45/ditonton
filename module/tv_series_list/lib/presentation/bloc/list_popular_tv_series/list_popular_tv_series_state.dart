part of 'list_popular_tv_series_bloc.dart';

abstract class ListPopularTvSeriesState extends Equatable {
  const ListPopularTvSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesEmpty extends ListPopularTvSeriesState {}

class PopularTvSeriesLoading extends ListPopularTvSeriesState {}

class PopularTvSeriesLoaded extends ListPopularTvSeriesState {
  final List<TvSeries> tvSeries;

  PopularTvSeriesLoaded({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class PopularTvSeriesError extends ListPopularTvSeriesState {
  final String message;

  PopularTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
