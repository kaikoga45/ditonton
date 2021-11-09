import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_detail/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailEmpty());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is FetchMovieDetail) {
      yield MovieDetailLoading();
      final detailResult = await getMovieDetail.execute(event.id);
      yield* detailResult.fold(
        (failure) async* {
          yield MovieDetailError(message: failure.message);
        },
        (result) async* {
          yield MovieDetailLoaded(
            movie: result,
          );
        },
      );
    }
  }
}
