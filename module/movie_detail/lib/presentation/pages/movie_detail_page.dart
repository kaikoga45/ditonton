import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_detail/movie_detail.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(FetchMovieDetail(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailLoaded) {
            return SafeArea(
              child: DetailContent(state.movie),
            );
          } else if (state is MovieDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;

  DetailContent(
    this.movie,
  );

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    context.read<MovieWatchlistBloc>().add(LoadWatchlistStatus(
          movieId: widget.movie.id,
          watchlistType: WatchlistType.Movie,
        ));
    context.read<MovieRecommendationBloc>().add(FetchMovieRecommendation(
          movieId: widget.movie.id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<MovieWatchlistBloc,
                                MovieWatchlistState>(builder: (context, state) {
                              if (state is MovieWatchlistLoading) {
                                return Center(
                                  key: Key('center_mw'),
                                  child: CircularProgressIndicator(
                                    key: Key('cpi_mw'),
                                  ),
                                );
                              } else if (state is MovieWatchlistLoaded) {
                                return ElevatedButton(
                                  key: Key('watchlist_button_mw'),
                                  onPressed: () {
                                    if (state.watchlistStatus) {
                                      context
                                          .read<MovieWatchlistBloc>()
                                          .add(RemoveMovieWatchlist(
                                            movieDetail: widget.movie,
                                            watchlistType: WatchlistType.Movie,
                                          ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Success remove from watchlist!')));
                                    } else {
                                      context.read<MovieWatchlistBloc>().add(
                                          AddMovieWatchlist(
                                              movieDetail: widget.movie));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Success adding to watchlist!')));
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      state.watchlistStatus
                                          ? Icon(
                                              Icons.check,
                                              key: Key('check_mw'),
                                            )
                                          : Icon(
                                              Icons.add,
                                              key: Key('add_mw'),
                                            ),
                                      Text('Watchlist')
                                    ],
                                  ),
                                );
                              } else if (state is MovieWatchlistError) {
                                return ElevatedButton(
                                  key: Key('error_mw'),
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Icon(Icons.error),
                                      Text(state.message),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationBloc,
                                MovieRecommendationState>(
                              builder: (context, state) {
                                if (state is MovieRecommendationLoading) {
                                  return Center(
                                    key: Key('center_mr'),
                                    child: CircularProgressIndicator(
                                      key: Key('cpi_mr'),
                                    ),
                                  );
                                } else if (state is MovieRecommendationError) {
                                  return Text(
                                    state.message,
                                    key: Key('text_mr'),
                                  );
                                } else if (state is MovieRecommendationLoaded) {
                                  return Container(
                                    key: Key('content_mr'),
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.movies[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.movies.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
