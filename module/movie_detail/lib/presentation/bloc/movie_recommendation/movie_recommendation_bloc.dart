import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_detail/movie_detail.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(MovieRecommendationEmpty());

  @override
  Stream<MovieRecommendationState> mapEventToState(
      MovieRecommendationEvent event) async* {
    if (event is FetchMovieRecommendation) {
      yield MovieRecommendationLoading();
      final recommendationResult =
          await getMovieRecommendations.execute(event.movieId);
      yield* recommendationResult.fold(
        (failure) async* {
          yield MovieRecommendationError(message: failure.message);
        },
        (result) async* {
          yield MovieRecommendationLoaded(movies: result);
        },
      );
    }
  }
}
