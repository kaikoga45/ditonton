import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_list/tv_series_list.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class ListTopRatedTvSeriesBloc
    extends Bloc<ListTopRatedTvSeriesEvent, ListTopRatedTvSeriesState> {
  final GetListTopRatedTvSeries getTopRatedTvSeries;

  ListTopRatedTvSeriesBloc({required this.getTopRatedTvSeries})
      : super(TopRatedTvSeriesEmpty());

  @override
  Stream<ListTopRatedTvSeriesState> mapEventToState(
    ListTopRatedTvSeriesEvent event,
  ) async* {
    if (event is FetchListTopRatedTvSeries) {
      yield TopRatedTvSeriesLoading();
      final result = await getTopRatedTvSeries.execute();
      yield* result.fold(
        (failure) async* {
          yield TopRatedTvSeriesError(message: failure.message);
        },
        (tvSeries) async* {
          yield TopRatedTvSeriesLoaded(tvSeries: tvSeries);
        },
      );
    }
  }
}
