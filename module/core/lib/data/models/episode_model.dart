import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
  });

  final int id;
  final String name;
  final String overview;
  final String stillPath;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        stillPath: json["still_path"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "still_path": stillPath,
      };

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      overview: overview,
      stillPath: stillPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        stillPath,
      ];
}
