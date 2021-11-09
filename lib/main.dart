import 'dart:async';

import 'package:core/core.dart';
import 'package:core/presentation/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_list/movie_list.dart';
import 'package:popular_movies/popular_movies.dart';
import 'package:popular_tv_series/popular_tv_series.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:top_rated_movies/top_rated_movies.dart';
import 'package:top_rated_tv_series/top_rated_tv_series.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_list/tv_series_list.dart';
import 'package:watchlist/watchlist.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await HttpSSLPinning.init();
    di.init();
    await Firebase.initializeApp();
    runApp(MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<ListNowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<ListPopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<ListTopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<ListTvOnAirBloc>()),
        BlocProvider(create: (_) => di.locator<ListPopularTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<ListTopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<ListTvSeasonBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                  builder: (_) => TvSeriesDetailPage(id: id));
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
