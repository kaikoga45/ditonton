import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesBloc({required this.searchTvSeries})
      : super(SearchTvSeriesEmpty());

  @override
  Stream<SearchTvSeriesState> mapEventToState(
      SearchTvSeriesEvent event) async* {
    if (event is FetchedSearchTvSeries) {
      yield SearchTvSeriesLoading();
      final result = await searchTvSeries.execute(event.query);
      yield* result.fold(
        (failure) async* {
          yield SearchTvSeriesError(message: failure.message);
        },
        (result) async* {
          yield SearchTvSeriesLoaded(tvSeries: result);
        },
      );
    }
  }

  @override
  Stream<Transition<SearchTvSeriesEvent, SearchTvSeriesState>> transformEvents(
      events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .flatMap((transitionFn));
  }
}
