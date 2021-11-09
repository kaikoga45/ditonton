import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  TvSeason({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.tvSeasonId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int tvSeasonId;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        tvSeasonId,
        tvSeasonId,
        posterPath,
        seasonNumber,
      ];
}
