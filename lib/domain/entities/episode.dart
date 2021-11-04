import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
  });

  final int id;
  final String name;
  final String overview;
  final String stillPath;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        stillPath,
      ];
}
