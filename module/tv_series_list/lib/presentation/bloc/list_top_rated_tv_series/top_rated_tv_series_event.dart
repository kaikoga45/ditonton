part of 'top_rated_tv_series_bloc.dart';

abstract class ListTopRatedTvSeriesEvent extends Equatable {
  const ListTopRatedTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchListTopRatedTvSeries extends ListTopRatedTvSeriesEvent {}
