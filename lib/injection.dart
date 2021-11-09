import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_list/movie_list.dart';
import 'package:popular_movies/popular_movies.dart';
import 'package:popular_tv_series/popular_tv_series.dart';
import 'package:search/search.dart';
import 'package:top_rated_movies/top_rated_movies.dart';
import 'package:top_rated_tv_series/top_rated_tv_series.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_list/tv_series_list.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => ListNowPlayingMoviesBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => ListPopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => ListTopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => ListTvOnAirBloc(
      getTvOnAir: locator(),
    ),
  );
  locator.registerFactory(
    () => ListPopularTvSeriesBloc(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => ListTopRatedTvSeriesBloc(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvSeriesBloc(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMoviesBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistBloc(
      getWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      getTvSeriesDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesRecommendationBloc(
      getTvSeriesRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationBloc(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => ListTvSeasonBloc(
      getTvSeason: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesWatchlistBloc(
      getWatchListStatus: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchListStatus: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(
      () => GetTvSeriesWatchListStatus(repository: locator()));
  locator.registerLazySingleton(() => GetWatchlist(repository: locator()));
  locator.registerLazySingleton(() => GetTvSeason(repository: locator()));
  locator.registerLazySingleton(() => GetMovieWatchlist(repository: locator()));
  locator.registerLazySingleton(
      () => GetMovieWatchListStatus(repository: locator()));
  locator.registerLazySingleton(
      () => RemoveWatchlistTvSerios(repository: locator()));
  locator.registerLazySingleton(
      () => SaveWatchlistTvSeries(repository: locator()));
  locator.registerLazySingleton(() => SearchTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(repository: locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesRecommendations(repository: locator()));
  locator
      .registerLazySingleton(() => GetTopRatedTvSeries(repository: locator()));
  locator.registerLazySingleton(
      () => GetListTopRatedTvSeries(repository: locator()));
  locator
      .registerLazySingleton(() => GetPopularTvSeries(repository: locator()));
  locator.registerLazySingleton(
      () => GetListPopularTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetTvOnAir(repository: locator()));
  locator.registerLazySingleton(() => GetListNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetListPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetListTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(repository: locator()));

  locator
      .registerLazySingleton(() => SaveWatchlistMovie(repository: locator()));
  locator
      .registerLazySingleton(() => RemoveWatchlistMovie(repository: locator()));

  // repository
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
      movieLocalDataSource: locator(),
      tvSeriesLocalDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
