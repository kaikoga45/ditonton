import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

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
              onChanged: (query) {
                context
                    .read<SearchMoviesBloc>()
                    .add(FetchedSearchMovies(query: query));
                context
                    .read<SearchTvSeriesBloc>()
                    .add(FetchedSearchTvSeries(query: query));
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
                  BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                    builder: (context, state) {
                      if (state is SearchMoviesLoading) {
                        return Center(
                          key: Key('center_sm'),
                          child: CircularProgressIndicator(
                            key: Key('progress_sm'),
                          ),
                        );
                      } else if (state is SearchMoviesLoaded) {
                        final result = state.movies;
                        return ListView.builder(
                          key: Key('sm'),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = state.movies[index];
                            return MovieCard(movie);
                          },
                          itemCount: result.length,
                        );
                      } else if (state is SearchMoviesError) {
                        return Text(
                          state.message,
                          key: Key('error_sm'),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                    builder: (context, state) {
                      if (state is SearchTvSeriesLoading) {
                        return Center(
                          key: Key('center_stv'),
                          child: CircularProgressIndicator(
                            key: Key('progress_stv'),
                          ),
                        );
                      } else if (state is SearchTvSeriesLoaded) {
                        final result = state.tvSeries;
                        return ListView.builder(
                          key: Key('stv'),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tvSeries = state.tvSeries[index];
                            return TvSeriesCard(tvSeries);
                          },
                          itemCount: result.length,
                        );
                      } else if (state is SearchTvSeriesError) {
                        return Text(
                          state.message,
                          key: Key('error_stv'),
                        );
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
