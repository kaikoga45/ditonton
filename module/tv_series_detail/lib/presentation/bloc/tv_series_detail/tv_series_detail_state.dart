part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailEmpty extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;

  TvSeriesDetailLoaded({required this.tvSeriesDetail});

  @override
  List<Object> get props => [tvSeriesDetail];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
