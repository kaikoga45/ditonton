import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final GetTvSeason getTvSeason;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSerios removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.getTvSeason,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;
  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  var _recommendations = <TvSeries>[];
  List<TvSeries> get recommendation => _recommendations;
  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  var _tvSeason = <TvSeason>[];
  List<TvSeason> get tvSeason => _tvSeason;
  RequestState _tvSeasonState = RequestState.Empty;
  RequestState get tvSeasonState => _tvSeasonState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold((failure) {
      _tvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesDetail) {
      _recommendationState = RequestState.Loading;
      _tvSeries = tvSeriesDetail;
      notifyListeners();
      recommendationResult.fold((failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
      }, (tvSeriesRecommendations) {
        _recommendationState = RequestState.Loaded;
        _recommendations = tvSeriesRecommendations;
      });
      _tvSeriesState = RequestState.Loaded;
      notifyListeners();
      fetchTvSeason(tvSeriesDetail.id, tvSeriesDetail.numberOfSeasons);
    });
  }

  Future<void> fetchTvSeason(int id, int totalSeason) async {
    _tvSeasonState = RequestState.Loading;
    notifyListeners();
    final result = await getTvSeason.execute(id, totalSeason);
    result.fold(
      (failure) {
        _tvSeasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeason) {
        _tvSeasonState = RequestState.Loaded;
        _tvSeason = tvSeason;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvSeriesDetail tvSeries, WatchlistType type) async {
    final result = await saveWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _tvSeriesState = RequestState.Error;
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id, type);
  }

  Future<void> removeFromWatchlist(
      TvSeriesDetail tvSeries, WatchlistType type) async {
    final result = await removeWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _tvSeriesState = RequestState.Error;
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id, type);
  }

  Future<void> loadWatchlistStatus(int id, WatchlistType type) async {
    final result = await getWatchListStatus.execute(id, type);
    result.fold((failure) {
      _tvSeriesState = RequestState.Error;
      _watchlistMessage = failure.message;
      notifyListeners();
    }, (status) {
      _isAddedtoWatchlist = status;
      notifyListeners();
    });
  }
}
