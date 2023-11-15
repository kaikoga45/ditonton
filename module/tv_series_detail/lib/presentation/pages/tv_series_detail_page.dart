import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<TvSeriesDetailBloc>().add(FetchTvSeriesDetail(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailLoaded) {
            return SafeArea(
              child: DetailContent(
                state.tvSeriesDetail,
                _tabController,
              ),
            );
          } else if (state is TvSeriesDetailError) {
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
  final TvSeriesDetail tvSeries;
  final TabController tabController;

  DetailContent(this.tvSeries, this.tabController);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    context
        .read<TvSeriesRecommendationBloc>()
        .add(FetchTvSeriesRecommendation(tvSeriesId: widget.tvSeries.id));
    context.read<ListTvSeasonBloc>().add(FetchTvSeason(
        tvId: widget.tvSeries.id,
        totalSeason: widget.tvSeries.numberOfSeasons));
    context.read<TvSeriesWatchlistBloc>().add(LoadWatchlistStatus(
        tvSeriesId: widget.tvSeries.id, watchlistType: WatchlistType.TvSeries));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        widget.tvSeries.posterPath.isEmpty
            ? Placeholder()
            : CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<TvSeriesWatchlistBloc,
                                    TvSeriesWatchlistState>(
                                builder: (context, state) {
                              if (state is TvSeriesWatchlistLoading) {
                                return Center(
                                  key: Key('center_tvm'),
                                  child: CircularProgressIndicator(
                                    key: Key('cpi_tvm'),
                                  ),
                                );
                              } else if (state is TvSeriesWatchlistLoaded) {
                                return ElevatedButton(
                                  key: Key('watchlist_button_tvm'),
                                  onPressed: () {
                                    if (state.watchlistStatus) {
                                      context
                                          .read<TvSeriesWatchlistBloc>()
                                          .add(RemoveTvSeriesWatchlist(
                                            tvSeriesDetail: widget.tvSeries,
                                            watchlistType:
                                                WatchlistType.TvSeries,
                                          ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Success remove from watchlist!')));
                                    } else {
                                      context.read<TvSeriesWatchlistBloc>().add(
                                          AddTvSeriesWatchlist(
                                              tvSeriesDetail: widget.tvSeries));
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
                                              key: Key('check_tvm'),
                                            )
                                          : Icon(
                                              Icons.add,
                                              key: Key('add_tvm'),
                                            ),
                                      Text('Watchlist')
                                    ],
                                  ),
                                );
                              } else if (state is TvSeriesWatchlistError) {
                                return ElevatedButton(
                                  key: Key('error_tvm'),
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
                              _showGenres(widget.tvSeries.genres),
                            ),
                            TvSeriesAirDate(tvSeries: widget.tvSeries),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 45,
                              child: TabBar(
                                controller: widget.tabController,
                                indicatorColor: kMikadoYellow,
                                tabs: [
                                  Tab(
                                    key: Key('tab_episode'),
                                    text: 'Episodes',
                                  ),
                                  Tab(
                                    key: Key('tab_recommendation'),
                                    text: 'Recommendation',
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: screenHeight * 0.38,
                              child: TabBarView(
                                controller: widget.tabController,
                                children: [
                                  widget.tvSeries.numberOfSeasons != 0
                                      ? TvSeasonContent()
                                      : Text('Empty Episode'),
                                  RecommendationContent(),
                                ],
                              ),
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
                Navigator.pop(context);
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
}

class RecommendationContent extends StatelessWidget {
  const RecommendationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      builder: (context, state) {
        if (state is TvSeriesRecommendationLoading) {
          return Center(
            key: Key('center_tvr'),
            child: CircularProgressIndicator(
              key: Key('cpi_tvr'),
            ),
          );
        } else if (state is TvSeriesRecommendationError) {
          return Text(state.message, key: Key('text_tvr'));
        } else if (state is TvSeriesRecommendationLoaded) {
          return Column(
            key: Key('content_tvr'),
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tvSeriesRecommendation = state.tvSeries[index];
                    return RecommendationCard(
                      tvSeriesRecommendation: tvSeriesRecommendation,
                    );
                  },
                  itemCount: state.tvSeries.length,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class TvSeasonContent extends StatefulWidget {
  const TvSeasonContent({
    Key? key,
  }) : super(key: key);

  @override
  State<TvSeasonContent> createState() => _TvSeasonContentState();
}

class _TvSeasonContentState extends State<TvSeasonContent> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListTvSeasonBloc, ListTvSeasonState>(
      builder: (context, state) {
        if (state is ListTvSeasonLoading) {
          return Center(
            key: Key('center_tvs'),
            child: CircularProgressIndicator(
              key: Key('cpi_tvs'),
            ),
          );
        } else if (state is ListTvSeasonError) {
          return Text(state.message, key: Key('error_tvs'));
        } else if (state is ListTvSeasonLoaded) {
          final tvSeason = state.tvSeasons[selectedIndex - 1];
          final items = setTotalDropdownMenuItem(state.tvSeasons.length);
          return Column(
            key: Key('content_tvs'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                  child: DropdownButton(
                    value: selectedIndex,
                    style: TextStyle(color: Colors.white),
                    items: items
                        .map((value) => DropdownMenuItem(
                              child: Text('Season $value'),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedIndex = value as int);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tvEpisode = tvSeason.episodes[index];
                    return TvEpisodeCard(
                      episode: tvEpisode,
                      index: index,
                    );
                  },
                  itemCount: tvSeason.episodes.length,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class TvSeriesAirDate extends StatelessWidget {
  const TvSeriesAirDate({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  final TvSeriesDetail tvSeries;

  @override
  Widget build(BuildContext context) {
    if (tvSeries.inProduction) {
      if (tvSeries.firstAirDate.isNotEmpty) {
        return Text('${tvSeries.firstAirDate} - Now');
      } else {
        return Text('Unknown Date Production');
      }
    } else {
      return Text('${tvSeries.firstAirDate} - ${tvSeries.lastAirDate}');
    }
  }
}

class TvEpisodeCard extends StatelessWidget {
  final Episode episode;
  final int index;

  TvEpisodeCard({required this.episode, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                child: episode.stillPath.isEmpty
                    ? Placeholder(
                        fallbackHeight: 80,
                        fallbackWidth: 150,
                      )
                    : CachedNetworkImage(
                        imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
                        width: 150,
                        height: 80,
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              SizedBox(width: 15),
              Expanded(child: Text('${index + 1}. ${episode.name}')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(episode.overview.isEmpty ? 'No Overview' : episode.overview),
        ],
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    Key? key,
    required this.tvSeriesRecommendation,
  }) : super(key: key);

  final TvSeries tvSeriesRecommendation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            TvSeriesDetailPage.ROUTE_NAME,
            arguments: tvSeriesRecommendation.id,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: tvSeriesRecommendation.posterPath?.isEmpty ?? false
              ? Placeholder(
                  fallbackWidth: 250,
                )
              : CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${tvSeriesRecommendation.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
        ),
      ),
    );
  }
}

List<int> setTotalDropdownMenuItem(int totalSeason) {
  List<int> totalItem = [];
  for (var i = 1; i < totalSeason + 1; i++) {
    totalItem.add(i);
  }
  return totalItem;
}
