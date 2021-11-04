import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_response.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_season_response.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/data/models/watchlist_tabel.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

/*
  DUMMY MOVIE
*/

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetailModel = MovieDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  budget: 1,
  genres: [GenreModel(id: 1, name: 'name')],
  homepage: 'homepage',
  id: 1,
  imdbId: 'imdbId',
  originalLanguage: 'originalLanguage',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  revenue: 1,
  runtime: 1,
  status: 'status',
  tagline: 'tagline',
  title: 'title',
  video: true,
  voteAverage: 1,
  voteCount: 1,
);

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistMovie = Watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  label: 'title',
  type: 'movie',
);

final testWatchlistMovieTabel = WatchlistTabel.movie(testMovieTable);

final testWatchlistMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'movies',
};

final testMovieTableMap = {
  'id': 1,
  'title': 'title',
  'posterPath': 'posterPath',
  'overview': 'overview',
  'type': 'movie',
};

final testMovieDetailMap = {
  "adult": false,
  "backdrop_path": "backdropPath",
  "budget": 1,
  "genres": [
    {
      "id": 1,
      "name": "name",
    }
  ],
  "homepage": "homepage",
  "id": 1,
  "imdb_id": "imdbId",
  "original_language": "originalLanguage",
  "original_title": "originalTitle",
  "overview": "overview",
  "popularity": 1.0,
  "poster_path": "posterPath",
  "release_date": "releaseDate",
  "revenue": 1,
  "runtime": 1,
  "status": "status",
  "tagline": "tagline",
  "title": "title",
  "video": true,
  "vote_average": 1,
  "vote_count": 1,
};

final testMovieMap = {
  "adult": false,
  "backdrop_path": 'backdropPath',
  "genre_ids": [1],
  "id": 1,
  "original_title": 'originalTitle',
  "overview": 'overview',
  "popularity": 1.0,
  "poster_path": 'posterPath',
  "release_date": 'releaseDate',
  "title": 'title',
  "video": true,
  "vote_average": 1,
  "vote_count": 1,
};

/*
  DUMMY TV SERIES
*/

final testTvSeries = TvSeries(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [],
  id: 1,
  name: 'name',
  originCountry: [],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Thriller')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  inProduction: false,
  lastAirDate: 'lastAirDate',
  numberOfSeasons: 1,
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesWatchlist = Watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  label: 'label',
  type: 'tvseries',
);

final testTvSeriesWatchlistEntity = TvSeries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testWatchlistTvSeriesTabel = WatchlistTabel.tvSeries(testTvSeriesTable);

final testTvSeriesDetailMap = {
  "backdrop_path": "backdropPath",
  "episode_run_time": [],
  "first_air_date": "firstAirDate",
  "genres": [
    {"id": 1, "name": "Thriller"}
  ],
  "homepage": "homepage",
  "id": 1,
  "in_production": false,
  "languages": [],
  "last_air_date": "lastAirDate",
  "name": "name",
  "next_episode_to_air": "nextEpisodeToAir",
  "number_of_episodes": 1,
  "number_of_seasons": 1,
  "origin_country": [],
  "original_language": "originalLanguage",
  "original_name": "originalName",
  "overview": "overview",
  "popularity": 1,
  "poster_path": "posterPath",
  "status": "status",
  "tagline": "tagline",
  "type": "type",
  "vote_average": 1,
  "vote_count": 1,
};

final testTvSeriesDetailModel = TvSeriesDetailResponse(
  backdropPath: 'backdropPath',
  episodeRunTime: [],
  firstAirDate: 'firstAirDate',
  genres: [GenreModel(id: 1, name: 'Thriller')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  languages: [],
  lastAirDate: 'lastAirDate',
  name: 'name',
  nextEpisodeToAir: 'nextEpisodeToAir',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: [],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesModel = TvSeriesModel(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [],
  id: 1,
  name: 'name',
  originCountry: [],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesMap = {
  "backdrop_path": "backdropPath",
  "first_air_date": "firstAirDate",
  "genre_ids": [],
  "id": 1,
  "name": "name",
  "origin_country": [],
  "original_language": "originalLanguage",
  "original_name": "originalName",
  "overview": "overview",
  "popularity": 1,
  "poster_path": "posterPath",
  "vote_average": 1,
  "vote_count": 1,
};

final testWathlistTvSeriesMap = {
  'id': 1,
  'name': "name",
  'posterPath': "posterPath",
  'overview': "overview",
  'type': "tvseries",
};

/*
Tv Season
*/

final testTvSeason = TvSeason(
  id: '52571edf760ee3776a1df79f',
  airDate: '2004-09-11',
  episodes: [
    Episode(
      id: 137907,
      name: 'The Bat in the Belfry',
      overview:
          'After stopping a heist by Rupert Thorne, Batman returns to the batcave to learn that all criminals in Arkham Asylum have mysteriously been released. Batman finds out that it\'s a crazed clown named Joker whom released them, and he plans to make a blimp full of laughing gas to explode over Gotham so every citizen in turns into a lunatic. It\'s up to Batman to stop him.',
      stillPath: '/cAxBIAUsSIM3spc9XhVczHbljyG.jpg',
    ),
  ],
  name: 'Season 1',
  overview: '',
  tvSeasonId: 6001,
  posterPath: '/1hePBrU6rr6iF3j3Qi2blt04lZQ.jpg',
  seasonNumber: 1,
);

final testTvSeasonResponse = TvSeasonResponse(
  id: '52571edf760ee3776a1df79f',
  airDate: '2004-09-11',
  episodes: [
    EpisodeModel(
      id: 137907,
      name: 'The Bat in the Belfry',
      overview:
          'After stopping a heist by Rupert Thorne, Batman returns to the batcave to learn that all criminals in Arkham Asylum have mysteriously been released. Batman finds out that it\'s a crazed clown named Joker whom released them, and he plans to make a blimp full of laughing gas to explode over Gotham so every citizen in turns into a lunatic. It\'s up to Batman to stop him.',
      stillPath: '/cAxBIAUsSIM3spc9XhVczHbljyG.jpg',
    ),
  ],
  name: 'Season 1',
  overview: '',
  tvSeasonId: 6001,
  posterPath: '/1hePBrU6rr6iF3j3Qi2blt04lZQ.jpg',
  seasonNumber: 1,
);

final testTvSeasonResponseMap = {
  "_id": "52571edf760ee3776a1df79f",
  "air_date": "2004-09-11",
  "episodes": [
    {
      "id": 137907,
      "name": "The Bat in the Belfry",
      "overview":
          "After stopping a heist by Rupert Thorne, Batman returns to the batcave to learn that all criminals in Arkham Asylum have mysteriously been released. Batman finds out that it\'s a crazed clown named Joker whom released them, and he plans to make a blimp full of laughing gas to explode over Gotham so every citizen in turns into a lunatic. It\'s up to Batman to stop him.",
      "still_path": "/cAxBIAUsSIM3spc9XhVczHbljyG.jpg",
    }
  ],
  "name": "Season 1",
  "overview": "",
  "id": 6001,
  "poster_path": "/1hePBrU6rr6iF3j3Qi2blt04lZQ.jpg",
  "season_number": 1
};

final testEpisodeModel = EpisodeModel(
  id: 137907,
  name: 'The Bat in the Belfry',
  overview:
      'After stopping a heist by Rupert Thorne, Batman returns to the batcave to learn that all criminals in Arkham Asylum have mysteriously been released. Batman finds out that it\'s a crazed clown named Joker whom released them, and he plans to make a blimp full of laughing gas to explode over Gotham so every citizen in turns into a lunatic. It\'s up to Batman to stop him.',
  stillPath: '/cAxBIAUsSIM3spc9XhVczHbljyG.jpg',
);

final testEpisode = Episode(
  id: 137907,
  name: 'The Bat in the Belfry',
  overview:
      'After stopping a heist by Rupert Thorne, Batman returns to the batcave to learn that all criminals in Arkham Asylum have mysteriously been released. Batman finds out that it\'s a crazed clown named Joker whom released them, and he plans to make a blimp full of laughing gas to explode over Gotham so every citizen in turns into a lunatic. It\'s up to Batman to stop him.',
  stillPath: '/cAxBIAUsSIM3spc9XhVczHbljyG.jpg',
);

final testEpisodeMap = {
  "id": 137907,
  "name": 'The Bat in the Belfry',
  "overview":
      'After stopping a heist by Rupert Thorne, Batman returns to the batcave to learn that all criminals in Arkham Asylum have mysteriously been released. Batman finds out that it\'s a crazed clown named Joker whom released them, and he plans to make a blimp full of laughing gas to explode over Gotham so every citizen in turns into a lunatic. It\'s up to Batman to stop him.',
  "still_path": '/cAxBIAUsSIM3spc9XhVczHbljyG.jpg',
};

final testTvSeasonResponseList = <TvSeasonResponse>[
  testTvSeasonResponse,
  testTvSeasonResponse,
];

final testTvSeasonList = <TvSeason>[
  testTvSeason,
  testTvSeason,
];
