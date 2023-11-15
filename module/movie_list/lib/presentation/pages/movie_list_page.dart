import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:movie_list/presentation/bloc/list_now_playing_movies/list_now_playing_movies_bloc.dart';
import 'package:movie_list/presentation/bloc/list_popular_movies/list_popular_movies_bloc.dart';
import 'package:movie_list/presentation/bloc/list_top_rated_movies/list_top_rated_movies_bloc.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key? key}) : super(key: Key('test'));

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ListNowPlayingMoviesBloc>().add(FetchListNowPlayingMovies());
    context.read<ListPopularMoviesBloc>().add(FetchListPopularMovies());
    context.read<ListTopRatedMoviesBloc>().add(FetchListTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Now Playing',
          style: kHeading6,
        ),
        BlocBuilder<ListNowPlayingMoviesBloc, ListNowPlayingMoviesState>(
            builder: (_, state) {
          if (state is NowPlayingMoviesLoading) {
            return Center(
              key: Key('center_npm'),
              child: CircularProgressIndicator(
                key: Key('progress_npm'),
              ),
            );
          } else if (state is NowPlayingMoviesLoaded) {
            return MovieList(state.movies, Key('npm'));
          } else if (state is NowPlayingMoviesError) {
            return Text(
              state.message,
              key: Key('error_npm'),
            );
          } else {
            return Container();
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES),
        ),
        BlocBuilder<ListPopularMoviesBloc, ListPopularMoviesState>(
            builder: (_, state) {
          if (state is PopularMoviesLoading) {
            return Center(
              key: Key('center_pm'),
              child: CircularProgressIndicator(
                key: Key('progress_pm'),
              ),
            );
          } else if (state is PopularMoviesLoaded) {
            return MovieList(state.movies, Key('pm'));
          } else if (state is PopularMoviesError) {
            return Text(
              state.message,
              key: Key('error_pm'),
            );
          } else {
            return Container();
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () => Navigator.pushNamed(context, TOP_RATED_MOVIES),
        ),
        BlocBuilder<ListTopRatedMoviesBloc, ListTopRatedMoviesState>(
            builder: (_, state) {
          if (state is TopRatedMoviesLoading) {
            return Center(
              key: Key('center_trm'),
              child: CircularProgressIndicator(
                key: Key('progress_trm'),
              ),
            );
          } else if (state is TopRatedMoviesLoaded) {
            return MovieList(
              state.movies,
              Key('trm'),
            );
          } else if (state is TopRatedMoviesError) {
            return Text(
              state.message,
              key: Key('error_trm'),
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Key key;

  MovieList(this.movies, this.key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAILS,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
