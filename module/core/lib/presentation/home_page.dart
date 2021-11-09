import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/presentation/pages/movie_list_page.dart';
import 'package:tv_series_list/presentation/pages/tv_series_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex;

  final body = <Widget>[
    MovieListPage(),
    TvSeriesListPage(),
  ];

  final title = <String>[
    'Movies',
    'Tv Series',
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                setState(() => selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title[selectedIndex]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: body[selectedIndex]),
      ),
    );
  }
}
