part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Watchlist> watchlist;

  const WatchlistLoaded({required this.watchlist});

  @override
  List<Object> get props => [watchlist];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}
