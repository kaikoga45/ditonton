import 'package:core/core.dart';

import 'package:equatable/equatable.dart';

class TvSeasonResponse extends Equatable {
  TvSeasonResponse({
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
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int tvSeasonId;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonResponse.fromJson(Map<String, dynamic> json) {
    return TvSeasonResponse(
      id: json["_id"],
      airDate: json["air_date"],
      episodes: List<EpisodeModel>.from(
          json["episodes"].map((x) => EpisodeModel.fromJson(x))),
      name: json["name"],
      overview: json["overview"],
      tvSeasonId: json["id"],
      posterPath: json["poster_path"],
      seasonNumber: json["season_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": tvSeasonId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  TvSeason toEntity() {
    return TvSeason(
      id: id,
      airDate: airDate,
      episodes: episodes.map((x) => x.toEntity()).toList(),
      name: name,
      overview: overview,
      tvSeasonId: tvSeasonId,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

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
