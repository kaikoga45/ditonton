import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies}) : super(SearchMoviesEmpty());

  @override
  Stream<SearchMoviesState> mapEventToState(
    SearchMoviesEvent event,
  ) async* {
    if (event is FetchedSearchMovies) {
      yield SearchMoviesLoading();
      final result = await searchMovies.execute(event.query);
      yield* result.fold(
        (failure) async* {
          yield SearchMoviesError(message: failure.message);
        },
        (result) async* {
          yield SearchMoviesLoaded(movies: result);
        },
      );
    }
  }

  @override
  Stream<Transition<SearchMoviesEvent, SearchMoviesState>> transformEvents(
      events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .flatMap((transitionFn));
  }
}
