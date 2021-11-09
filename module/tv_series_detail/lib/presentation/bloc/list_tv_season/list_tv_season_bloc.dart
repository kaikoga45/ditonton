import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

part 'list_tv_season_event.dart';
part 'list_tv_season_state.dart';

class ListTvSeasonBloc extends Bloc<ListTvSeasonEvent, ListTvSeasonState> {
  final GetTvSeason getTvSeason;

  ListTvSeasonBloc({required this.getTvSeason}) : super(ListTvSeasonEmpty());

  @override
  Stream<ListTvSeasonState> mapEventToState(
    ListTvSeasonEvent event,
  ) async* {
    if (event is FetchTvSeason) {
      yield ListTvSeasonLoading();
      final result = await getTvSeason.execute(event.tvId, event.totalSeason);
      yield* result.fold(
        (failure) async* {
          yield ListTvSeasonError(message: failure.message);
        },
        (tvSeason) async* {
          yield ListTvSeasonLoaded(tvSeasons: tvSeason);
        },
      );
    }
  }
}
