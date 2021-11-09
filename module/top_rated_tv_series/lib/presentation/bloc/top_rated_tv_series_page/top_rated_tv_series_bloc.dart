import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:top_rated_tv_series/top_rated_tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc({required this.getTopRatedTvSeries})
      : super(TopRatedTvSeriesEmpty());

  @override
  Stream<TopRatedTvSeriesState> mapEventToState(
    TopRatedTvSeriesEvent event,
  ) async* {
    if (event is FetchTopRatedTvSeries) {
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
