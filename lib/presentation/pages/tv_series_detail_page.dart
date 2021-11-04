import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
        ..fetchTvSeriesDetail(widget.id)
        ..loadWatchlistStatus(widget.id, WatchlistType.TvSeries);
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final tvSeries = provider.tvSeries;
            return SafeArea(
              child: DetailContent(
                tvSeries,
                provider.isAddedToWatchlist,
                _tabController,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final bool isAddedWatchlist;
  final TabController tabController;

  DetailContent(this.tvSeries, this.isAddedWatchlist, this.tabController);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(
                                          tvSeries, WatchlistType.TvSeries);
                                } else {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(
                                          tvSeries, WatchlistType.TvSeries);
                                }

                                final message =
                                    Provider.of<TvSeriesDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        TvSeriesDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvSeriesDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            TvSeriesAirDate(tvSeries: tvSeries),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 45,
                              child: TabBar(
                                controller: tabController,
                                indicatorColor: kMikadoYellow,
                                tabs: [
                                  Tab(
                                    text: 'Episodes',
                                  ),
                                  Tab(
                                    text: 'Recommendation',
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: screenHeight * 0.38,
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  tvSeries.numberOfSeasons != 0
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
    return Consumer<TvSeriesDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.Loading) {
          return Center(
            key: Key('center_recommendation_content'),
            child: CircularProgressIndicator(
              key: Key('progress_bar_recommendation_content'),
            ),
          );
        } else if (data.recommendationState == RequestState.Error) {
          return Text(data.message, key: Key('error_recommendation_content'));
        } else if (data.recommendationState == RequestState.Loaded) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tvSeriesRecommendation = data.recommendation[index];
                    return RecommendationCard(
                      tvSeriesRecommendation: tvSeriesRecommendation,
                    );
                  },
                  itemCount: data.recommendation.length,
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
    return Consumer<TvSeriesDetailNotifier>(
      builder: (context, data, child) {
        if (data.tvSeasonState == RequestState.Loading) {
          return Center(
            key: Key('center_tv_season_content'),
            child: CircularProgressIndicator(
              key: Key('progress_bar_tv_season_content'),
            ),
          );
        } else if (data.tvSeasonState == RequestState.Error) {
          return Text(data.message, key: Key('error_tv_season_content'));
        } else if (data.tvSeasonState == RequestState.Loaded) {
          final tvSeason = data.tvSeason[selectedIndex - 1];
          final items = setTotalDropdownMenuItem(data.tvSeason.length);
          return Column(
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
                child: CachedNetworkImage(
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
          child: CachedNetworkImage(
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
