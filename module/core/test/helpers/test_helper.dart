import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  WatchlistRepository,
  MovieRepository,
  TvSeriesRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
