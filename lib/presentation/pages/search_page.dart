import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
                Provider.of<TvSeriesSearchNotifier>(context, listen: false)
                    .fetchTvSeriesSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Expanded(
              child: ListView(
                children: [
                  Consumer<MovieSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.Loaded) {
                        final result = data.searchResult;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = data.searchResult[index];
                            return MovieCard(movie);
                          },
                          itemCount: result.length,
                        );
                      } else if (data.state == RequestState.Error) {
                        return Text(data.message);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Consumer<TvSeriesSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.Loaded) {
                        final result = data.searchResult;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tvSeries = data.searchResult[index];
                            return TvSeriesCard(tvSeries);
                          },
                          itemCount: result.length,
                        );
                      } else if (data.state == RequestState.Error) {
                        return Text(data.message);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}