import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_on_air.dart';
import 'package:flutter/material.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _tvOnAir = <TvSeries>[];
  List<TvSeries> get tvOnAir => _tvOnAir;
  RequestState _tvOnAirState = RequestState.Empty;
  RequestState get tvOnAirState => _tvOnAirState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;
  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;
  RequestState _topRatedTvSeriesState = RequestState.Empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getTvOnAir,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  final GetTvOnAir getTvOnAir;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchTvOnAir() async {
    _tvOnAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnAir.execute();

    result.fold(
      (failure) {
        _tvOnAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvOnAirData) {
        _tvOnAirState = RequestState.Loaded;
        _tvOnAir = tvOnAirData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();
    final result = await getPopularTvSeries.execute();
    result.fold((failure) {
      _popularTvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (popularTvSeries) {
      _popularTvSeries = popularTvSeries;
      _popularTvSeriesState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedTvSeries.execute();
    result.fold((failure) {
      _topRatedTvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (topRatedTvSeries) {
      _topRatedTvSeries = topRatedTvSeries;
      _topRatedTvSeriesState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
