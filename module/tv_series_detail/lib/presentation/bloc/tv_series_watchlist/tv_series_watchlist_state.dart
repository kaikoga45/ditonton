part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoaded extends TvSeriesWatchlistState {
  final bool watchlistStatus;

  TvSeriesWatchlistLoaded({required this.watchlistStatus});

  @override
  List<Object> get props => [watchlistStatus];
}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}
