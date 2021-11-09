part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends TvSeriesWatchlistEvent {
  final int tvSeriesId;
  final WatchlistType watchlistType;

  LoadWatchlistStatus({required this.tvSeriesId, required this.watchlistType});

  @override
  List<Object> get props => [tvSeriesId, watchlistType];
}

class AddTvSeriesWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  AddTvSeriesWatchlist({required this.tvSeriesDetail});

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveTvSeriesWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;
  final WatchlistType watchlistType;

  RemoveTvSeriesWatchlist(
      {required this.tvSeriesDetail, required this.watchlistType});

  @override
  List<Object> get props => [tvSeriesDetail, watchlistType];
}
