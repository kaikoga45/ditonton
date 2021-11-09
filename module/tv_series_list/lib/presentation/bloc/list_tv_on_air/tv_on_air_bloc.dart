import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:tv_series_list/tv_series_list.dart';

import 'package:equatable/equatable.dart';

part 'tv_on_air_event.dart';
part 'tv_on_air_state.dart';

class ListTvOnAirBloc extends Bloc<ListTvOnAirEvent, ListTvOnAirState> {
  final GetTvOnAir getTvOnAir;

  ListTvOnAirBloc({required this.getTvOnAir}) : super(TvOnAirEmpty());

  @override
  Stream<ListTvOnAirState> mapEventToState(
    ListTvOnAirEvent event,
  ) async* {
    if (event is FetchTvOnAir) {
      yield TvOnAirLoading();
      final result = await getTvOnAir.execute();
      yield* result.fold(
        (failure) async* {
          yield TvOnAirError(message: failure.message);
        },
        (tvOnAir) async* {
          yield TvOnAirLoaded(tvOnAir: tvOnAir);
        },
      );
    }
  }
}
