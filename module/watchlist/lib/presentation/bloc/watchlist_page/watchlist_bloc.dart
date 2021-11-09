import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;

  WatchlistBloc({required this.getWatchlist}) : super(WatchlistEmpty());

  @override
  Stream<WatchlistState> mapEventToState(WatchlistEvent event) async* {
    if (event is FetchWatchlist) {
      yield WatchlistLoading();
      final result = await getWatchlist.execute();
      yield* result.fold(
        (failure) async* {
          yield WatchlistError(message: failure.message);
        },
        (watchlist) async* {
          yield WatchlistLoaded(watchlist: watchlist);
        },
      );
    }
  }
}
