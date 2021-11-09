part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  FetchTvSeriesDetail({required this.id});

  @override
  List<Object> get props => [id];
}
