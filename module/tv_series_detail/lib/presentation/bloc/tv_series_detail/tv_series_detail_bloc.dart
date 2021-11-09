import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailBloc({required this.getTvSeriesDetail})
      : super(TvSeriesDetailEmpty());

  @override
  Stream<TvSeriesDetailState> mapEventToState(
    TvSeriesDetailEvent event,
  ) async* {
    if (event is FetchTvSeriesDetail) {
      yield TvSeriesDetailLoading();
      final result = await getTvSeriesDetail.execute(event.id);
      yield* result.fold(
        (failure) async* {
          yield TvSeriesDetailError(message: failure.message);
        },
        (tvSeriesDetail) async* {
          yield TvSeriesDetailLoaded(tvSeriesDetail: tvSeriesDetail);
        },
      );
    }
  }
}
