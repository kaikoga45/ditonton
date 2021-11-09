part of 'list_popular_tv_series_bloc.dart';

abstract class ListPopularTvSeriesEvent extends Equatable {
  const ListPopularTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchListPopularTvSeries extends ListPopularTvSeriesEvent {}
