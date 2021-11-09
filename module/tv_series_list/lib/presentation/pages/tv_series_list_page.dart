import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_list/tv_series_list.dart';

class TvSeriesListPage extends StatefulWidget {
  @override
  _TvSeriesListPageState createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ListTvOnAirBloc>().add(FetchTvOnAir());
    context.read<ListPopularTvSeriesBloc>().add(FetchListPopularTvSeries());
    context.read<ListTopRatedTvSeriesBloc>().add(FetchListTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tv On Air',
          style: kHeading6,
        ),
        BlocBuilder<ListTvOnAirBloc, ListTvOnAirState>(builder: (_, state) {
          if (state is TvOnAirLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvOnAirLoaded) {
            return TvSeriesList(state.tvOnAir);
          } else if (state is TvOnAirError) {
            return Text(state.message);
          } else {
            return Container();
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () {
            Navigator.pushNamed(context, POPULAR_TV_SERIES);
          },
        ),
        BlocBuilder<ListPopularTvSeriesBloc, ListPopularTvSeriesState>(
            builder: (_, state) {
          if (state is PopularTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvSeriesLoaded) {
            return TvSeriesList(state.tvSeries);
          } else if (state is PopularTvSeriesError) {
            return Text(state.message);
          } else {
            return Container();
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () {
            Navigator.pushNamed(context, TOP_RATED_TV_SERIES);
          },
        ),
        BlocBuilder<ListTopRatedTvSeriesBloc, ListTopRatedTvSeriesState>(
            builder: (_, state) {
          if (state is TopRatedTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTvSeriesLoaded) {
            return TvSeriesList(state.tvSeries);
          } else if (state is TopRatedTvSeriesError) {
            return Text(state.message);
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

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_SERIES_DETAILS,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
