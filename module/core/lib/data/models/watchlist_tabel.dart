import 'package:core/core.dart';

import 'package:equatable/equatable.dart';

class WatchlistTabel extends Equatable {
  WatchlistTabel({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.label,
    required this.type,
  });

  final int id;
  final String? overview;
  final String posterPath;
  final String label;
  final String type;

  factory WatchlistTabel.movie(MovieTable movie) => WatchlistTabel(
        id: movie.id,
        overview: movie.overview,
        posterPath: movie.posterPath,
        label: movie.title,
        type: movie.type,
      );

  factory WatchlistTabel.tvSeries(TvSeriesTable tvSeries) => WatchlistTabel(
        id: tvSeries.id,
        overview: tvSeries.overview,
        posterPath: tvSeries.posterPath,
        label: tvSeries.name,
        type: tvSeries.type,
      );

  Watchlist toEntity() {
    return Watchlist(
      id: this.id,
      overview: this.overview,
      posterPath: this.posterPath,
      label: this.label,
      type: this.type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        label,
        type,
      ];
}
