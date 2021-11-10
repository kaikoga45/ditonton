import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(FetchWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return Center(
                key: Key('center_wl'),
                child: CircularProgressIndicator(
                  key: Key('progress_wl'),
                ),
              );
            } else if (state is WatchlistLoaded) {
              return ListView.builder(
                key: Key('wl'),
                itemBuilder: (context, index) {
                  final watchList = state.watchlist[index];
                  return WatchlistCard(
                    watchList,
                  );
                },
                itemCount: state.watchlist.length,
              );
            } else if (state is WatchlistError) {
              return Center(
                key: Key('error_wl'),
                child: Text(state.message),
              );
            }
            {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
