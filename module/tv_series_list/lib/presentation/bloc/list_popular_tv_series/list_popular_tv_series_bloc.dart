import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_list/tv_series_list.dart';

part 'list_popular_tv_series_event.dart';
part 'list_popular_tv_series_state.dart';

class ListPopularTvSeriesBloc
    extends Bloc<ListPopularTvSeriesEvent, ListPopularTvSeriesState> {
  final GetListPopularTvSeries getPopularTvSeries;

  ListPopularTvSeriesBloc({required this.getPopularTvSeries})
      : super(PopularTvSeriesEmpty());

  @override
  Stream<ListPopularTvSeriesState> mapEventToState(
    ListPopularTvSeriesEvent event,
  ) async* {
    if (event is FetchListPopularTvSeries) {
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
