import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import 'package:equatable/equatable.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationBloc({required this.getTvSeriesRecommendations})
      : super(TvSeriesRecommendationEmpty());

  @override
  Stream<TvSeriesRecommendationState> mapEventToState(
    TvSeriesRecommendationEvent event,
  ) async* {
    if (event is FetchTvSeriesRecommendation) {
      yield TvSeriesRecommendationLoading();
      final result = await getTvSeriesRecommendations.execute(event.tvSeriesId);
      yield* result.fold(
        (failure) async* {
          yield TvSeriesRecommendationError(message: failure.message);
        },
        (tvSeries) async* {
          yield TvSeriesRecommendationLoaded(
            tvSeries: tvSeries,
          );
        },
      );
    }
  }
}
