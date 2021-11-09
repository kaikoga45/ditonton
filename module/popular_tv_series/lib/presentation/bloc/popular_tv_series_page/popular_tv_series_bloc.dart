import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:popular_tv_series/popular_tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc({required this.getPopularTvSeries})
      : super(PopularTvSeriesEmpty());

  @override
  Stream<PopularTvSeriesState> mapEventToState(
    PopularTvSeriesEvent event,
  ) async* {
    if (event is FetchPopularTvSeries) {
      yield PopularTvSeriesLoading();
      final result = await getPopularTvSeries.execute();
      yield* result.fold(
        (failure) async* {
          yield PopularTvSeriesError(message: failure.message);
        },
        (tvSeries) async* {
          yield PopularTvSeriesLoaded(tvSeries: tvSeries);
        },
      );
    }
  }
}
