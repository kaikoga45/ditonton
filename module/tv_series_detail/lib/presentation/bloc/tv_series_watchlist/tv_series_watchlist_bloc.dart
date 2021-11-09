import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetTvSeriesWatchListStatus getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSerios removeWatchlistTvSeries;

  TvSeriesWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(TvSeriesWatchlistEmpty());

  @override
  Stream<TvSeriesWatchlistState> mapEventToState(
      TvSeriesWatchlistEvent event) async* {
    if (event is LoadWatchlistStatus) {
      yield TvSeriesWatchlistLoading();
      final result = await getWatchListStatus.execute(
          event.tvSeriesId, event.watchlistType);
      yield* result.fold(
        (failure) async* {
          yield TvSeriesWatchlistError(message: failure.message);
        },
        (result) async* {
          yield TvSeriesWatchlistLoaded(watchlistStatus: result);
        },
      );
    } else if (event is AddTvSeriesWatchlist) {
      yield TvSeriesWatchlistLoading();
      final result = await saveWatchlistTvSeries.execute(event.tvSeriesDetail);
      yield* result.fold(
        (failure) async* {
          yield TvSeriesWatchlistError(message: failure.message);
        },
        (result) async* {
          yield TvSeriesWatchlistLoaded(watchlistStatus: true);
        },
      );
    } else if (event is RemoveTvSeriesWatchlist) {
      yield TvSeriesWatchlistLoading();
      final result =
          await removeWatchlistTvSeries.execute(event.tvSeriesDetail);
      yield* result.fold(
        (failure) async* {
          yield TvSeriesWatchlistError(message: failure.message);
        },
        (result) async* {
          yield TvSeriesWatchlistLoaded(watchlistStatus: false);
        },
      );
    }
  }
}
